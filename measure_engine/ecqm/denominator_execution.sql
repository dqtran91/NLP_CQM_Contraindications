/**********************************************
 Population Criteria:
 - Denominator Exclusions:
 "Encounter Less Than 2 Days"
    union "Encounter with ICU Location Stay 1 Day or More"
    union "Encounter with Principal Diagnosis of Mental Disorder or Stroke"
    union "Encounter with Principal Procedure of SCIP VTE Selected Surgery"
    union "Encounter with Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission"
    union "Encounter with Intervention Comfort Measures on Day of or Day After Procedure"
**********************************************/
DROP TABLE IF EXISTS denominator_exclusions;
CREATE TEMP TABLE IF NOT EXISTS denominator_exclusions AS
/*
 Definitions:
 - Encounter Less Than 2 Days:
 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
 where Global."LengthInDays" ( QualifyingEncounter.relevantPeriod ) < 2
 */
SELECT *
FROM vte.encounter_within_age_and_without_vte_or_obstetrical_conditions AS qualifying_encounter
WHERE global.length_in_days(relevant_period) < 2 -- relevantPeriod in days
UNION DISTINCT
/*
 Definitions:
 - Encounter with ICU Location Stay 1 Day or More:
 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
 where exists (
    QualifyingEncounter.facilityLocations Location
    where Location.code in "Intensive Care Unit"
        and Global."LengthInDays" ( Location.locationPeriod ) >= 1
        and Location.locationPeriod starts
            during Interval[start of QualifyingEncounter.relevantPeriod, TJC."TruncateTime" ( start of QualifyingEncounter.relevantPeriod + 2 days ) ) )
 */
SELECT *
FROM vte.encounter_within_age_and_without_vte_or_obstetrical_conditions AS qualifying_encounter
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(qualifying_encounter.facility_locations) AS location
              WHERE location ->> 'code' = 'ICU'
                AND global.length_in_days(cql.to_tsrange(location ->> 'location_period')) >= 1
                --  && is the overlap operator for TSRANGE and is equivalent to `starts during`
                AND cql.to_tsrange(location ->> 'location_period') &&
                    TSRANGE(LOWER(qualifying_encounter.relevant_period),
                            tjc.truncate_time(UPPER(qualifying_encounter.relevant_period)) + INTERVAL '2 days', '[)'))
UNION DISTINCT
/*
 Definitions:
 - Encounter with Principal Diagnosis of Mental Disorder or Stroke:
 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
 where exists (
    QualifyingEncounter.diagnoses EncounterDiagnoses
    where EncounterDiagnoses.rank = 1
        and ( EncounterDiagnoses.code in "Mental Health Diagnoses"
            or EncounterDiagnoses.code in "Hemorrhagic Stroke"
            or EncounterDiagnoses.code in "Ischemic Stroke") )
 */
SELECT *
FROM vte.encounter_within_age_and_without_vte_or_obstetrical_conditions AS qualifying_encounter
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(qualifying_encounter.diagnoses) AS encounter_diagnoses
              WHERE encounter_diagnoses ->> 'rank' = '1'
                AND encounter_diagnoses ->> 'code' IN (SELECT code
                                                       FROM cql.get_icd9_code('value_set', 'mental_health_diagnoses')
                                                       UNION DISTINCT
                                                       SELECT code
                                                       FROM cql.get_icd9_code('value_set', 'hemorrhagic_stroke')
                                                       UNION DISTINCT
                                                       SELECT code
                                                       FROM cql.get_icd9_code('value_set', 'ischemic_stroke')))
UNION DISTINCT
/*
 Definitions:
 Encounter with Principal Procedure of SCIP VTE Selected Surgery:
 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
    with ( "SCIP VTE Selected Surgery" Procedure where Procedure.rank = 1 ) SelectedSCIPProcedure
        such that Global."NormalizeInterval" ( SelectedSCIPProcedure.relevantDatetime, SelectedSCIPProcedure.relevantPeriod )
            during QualifyingEncounter.relevantPeriod
 // Note:
    relevant dateTime references the time the procedure is performed when the procedure occurs at a single point in time.
    relevantPeriod references a start and stop time for a procedure that occurs over a time interval.
    Mimic-III does not store either attributes, so it is assumed that the procedure is performed during the encounter relevantPeriod.

 SCIP VTE Selected Surgery:
 ["Procedure, Performed": "General Surgery"]
    union ["Procedure, Performed": "Gynecological Surgery"]
    union ["Procedure, Performed": "Hip Fracture Surgery"]
    union ["Procedure, Performed": "Hip Replacement Surgery"]
    union ["Procedure, Performed": "Intracranial Neurosurgery"]
    union ["Procedure, Performed": "Knee Replacement Surgery"]
    union ["Procedure, Performed": "Urological Surgery"]
 */
SELECT qualifying_encounter.*
FROM vte.encounter_within_age_and_without_vte_or_obstetrical_conditions AS qualifying_encounter
JOIN (SELECT *,
             NULL AS relevant_datetime,
             NULL AS relevant_period
      FROM mimiciii.procedures_icd AS procedure
      WHERE seq_num = 1 -- rank
        AND icd9_code IN (SELECT code
                          FROM cql.get_icd9_code('value_set', 'general_surgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'gynecological_surgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'hip_fracture_surgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'hip_replacement_surgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'intracranial_neurosurgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'knee_replacement_surgery')
                          UNION DISTINCT
                          SELECT code
                          FROM cql.get_icd9_code('value_set', 'urological_surgery'))) AS selected_scip_procedure
     ON qualifying_encounter.hadm_id = selected_scip_procedure.hadm_id
WHERE global.normalize_interval(selected_scip_procedure.relevant_datetime, COALESCE(selected_scip_procedure.relevant_period, qualifying_encounter.relevant_period))
      && qualifying_encounter.relevant_period
UNION DISTINCT
/*
 Definitions:
 - Encounter with Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission:
 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
 with "Intervention Comfort Measures" ComfortMeasures
    such that Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod), ComfortMeasures.authorDatetime)
        during day of VTE."FromDayOfStartOfHospitalizationToDayAfterAdmission" ( QualifyingEncounter )
 // Note:
    No comfort measures are found in the mimic-iii database.
 */
SELECT qualifying_encounter.*
FROM vte.encounter_within_age_and_without_vte_or_obstetrical_conditions AS qualifying_encounter
JOIN (SELECT *,
             NULL AS relevant_datetime,
             NULL AS relevant_period,
             NULL AS author_datetime
      FROM mimiciii.procedures_icd AS procedure
      WHERE seq_num = 1 -- rank
        AND icd9_code IN (SELECT code
                          FROM cql.get_icd9_code('value_set', 'comfort_measures'))) AS comfort_measures
ON qualifying_encounter.hadm_id = comfort_measures.hadm_id
WHERE COALESCE(LOWER(global.normalize_interval(comfort_measures.relevant_datetime, comfort_measures.relevant_datetime)), comfort_measures.author_datetime)
    -- <@ is the contains operator for TSRANGE and is equivalent to `during` between TIMESTAMPS and TSRANGES
    <@ vte.from_day_of_start_of_hospitalization_to_day_after_admission(ROW(qualifying_encounter.hadm_id, qualifying_encounter.relevant_period))
UNION DISTINCT
/*
 Definitions:
 - Encounter with Intervention Comfort Measures on Day of or Day After Procedure:
 from
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
    ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
    "Intervention Comfort Measures" ComfortMeasures
 where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod )
        ends 1 day after day of start of QualifyingEncounter.relevantPeriod
    and Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod), ComfortMeasures.authorDatetime)
        during day of TJC."CalendarDayOfOrDayAfter" (end of Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
 return QualifyingEncounter

 // Note:
    No comfort measures are found in the mimic-iii database.
 */
SELECT qualifyingencounter.*
FROM encounter_without_vte_or_obstetrical_diagnosis AS qualifyingencounter
JOIN value_set.comfort_measures                     AS comfortmeasures
     ON qualifyingencounter.hadm_id = comfortmeasures.hadm_id;

/**********************************************
  Population Criteria:
  Denominator
    "Initial Population"

 **********************************************/
DROP TABLE IF EXISTS denominator;
CREATE TEMP TABLE IF NOT EXISTS denominator AS
SELECT * FROM encounter_without_vte_or_obstetrical_diagnosis EXCEPT SELECT * FROM denominator_exclusions;