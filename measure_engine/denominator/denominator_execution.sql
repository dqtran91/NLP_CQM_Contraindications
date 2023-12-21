/********************************************************************************************
 General CQL:
 With - Filter based on relationships to other entities.
 // Note:
    Essentially a join. https://cql.hl7.org/02-authorsguide.html#relationships

 Interval[Start, End] - Interval from Start to End. '[' is inclusive and ')' is exclusive
 // Note:
    Interval[1, 3) contains the integers 1 and 2, but not 3. https://cql.hl7.org/02-authorsguide.html#interval-values

 During (included in) - for interval X and Y, the start of x >= start of y and end of x <= end of y
    // Note:
    https://cql.hl7.org/02-authorsguide.html#comparing-intervals

 Functions:
 Global.HospitalizationWithObservation(Encounter "Encounter, Performed")
    Encounter Visit
	    let ObsVisit: Last(["Encounter, Performed": "Observation Services"] LastObs
			where LastObs.relevantPeriod ends 1 hour or less on or before start of Visit.relevantPeriod
			sort by
			end of relevantPeriod
	    ),
	    VisitStart: Coalesce(start of ObsVisit.relevantPeriod, start of Visit.relevantPeriod),
	    EDVisit: Last(["Encounter, Performed": "Emergency Department Visit"] LastED
			where LastED.relevantPeriod ends 1 hour or less on or before VisitStart
			sort by
			end of relevantPeriod
	    )
	    return Interval[Coalesce(start of EDVisit.relevantPeriod, VisitStart),
	    end of Visit.relevantPeriod]

 Global.LengthInDays(Value Interval<DateTime>)
    difference in days between start of Value and end of Value

 Global.NormalizeInterval(pointInTime DateTime, period Interval<DateTime>)
    if pointInTime is not null then Interval[pointInTime, pointInTime]
    else if period is not null then period
    else null as Interval<DateTime>
 // Note:
  If the time is not null, then return the time. Else if the time is null and the period is not null,
  then return the period. Otherwise, return null.

 VTE.FromDayOfStartOfHospitalizationToDayAfterAdmission(Encounter "Encounter, Performed")
    Interval[TJC."TruncateTime" ( start of Global."HospitalizationWithObservation" ( Encounter ) ),
             TJC."TruncateTime" ( start of Encounter.relevantPeriod + 2 days ) )

 TJC.TruncateTime(Value DateTime)
    DateTime(year from Value, month from Value, day from Value, 0, 0, 0, 0, timezoneoffset from Value)
 // Note:
    Mimic does not stores time zone offset, so it is not used. Also, datetime is stored as timestamp(0)
    so it is truncated to the nearest second.
 ********************************************************************************************/

/**********************************************
 Population Criteria:
 Initial Population
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions"
 **********************************************/
/*
 Definitions:
 VTE.Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions
    ( Global."Inpatient Encounter" InpatientEncounter
        where AgeInYearsAt(date from start of InpatientEncounter.relevantPeriod) >= 18 )
    intersect "Admission without VTE or Obstetrical Conditions"
 // Note:
    The relevantPeriod addresses admission time and discharge time.
    https://ecqi.healthit.gov/mcw/2023/ecqm-dataelement/encounterperformedencounterinpatient.html
    Age cannot be calculated because MIMIC shifted the date of birth to protect patient privacy
    https://mimic.mit.edu/docs/iii/tables/patients/
 */
DROP TABLE IF EXISTS encounter_without_vte_or_obstetrical_diagnosis;
CREATE TEMP TABLE IF NOT EXISTS encounter_without_vte_or_obstetrical_diagnosis AS
    /*
     Global.Inpatient Encounter
        ["Encounter, Performed": "Encounter Inpatient"] EncounterInpatient
        where "LengthInDays"(EncounterInpatient.relevantPeriod)<= 120
            and EncounterInpatient.relevantPeriod ends during day of "Measurement Period"
     Measurement Period
        January 1, 20XX through December 31, 20XX
     // Note:
        Measurement Period can not be considered because the dates are shifted to protect patient privacy,
        so all encounters are considered.
     */
SELECT *
FROM qdm.Encounter AS encounter_inpatient
WHERE cql.length_in_days(relevantPeriod) <= 120 -- relevantPeriod in days
/*
 Definitions:
 VTE.Admission without VTE or Obstetrical Conditions
    Global."Inpatient Encounter" InpatientEncounter
    where not ( exists (
        InpatientEncounter.diagnoses EncounterDiagnoses
        where ( EncounterDiagnoses.code in "Obstetrics"
            or EncounterDiagnoses.code in "Venous Thromboembolism"
            or EncounterDiagnoses.code in "Obstetrics VTE") ) )
 */
INTERSECT
SELECT *
FROM qdm.encounter AS inpatient_encounter
WHERE NOT EXISTS (SELECT 1
                  FROM JSONB_ARRAY_ELEMENTS(inpatient_encounter.diagnoses) AS encounter_diagnoses
                  WHERE (encounter_diagnoses ->> 'code' IN (SELECT code FROM cql.get_icd9_code('valueSet', 'obstetrics'))
                      OR encounter_diagnoses ->> 'code' IN (SELECT code FROM cql.get_icd9_code('valueSet', 'venousThromboembolism'))
                      OR encounter_diagnoses ->> 'code' IN (SELECT code FROM cql.get_icd9_code('valueSet', 'obstetricsVTE'))));

/**********************************************
  Population Criteria:
  Denominator
    "Initial Population"

  Denominator Exclusions
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
     Encounter Less Than 2 Days
        VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
            where Global."LengthInDays" ( QualifyingEncounter.relevantPeriod ) < 2
     // Note:
        relevantPeriod is discharge time minus admission time.
        https://ecqi.healthit.gov/mcw/2023/ecqm-dataelement/encounterperformedencounterinpatient.html
     */
SELECT *
FROM encounter_without_vte_or_obstetrical_diagnosis AS qualifyingencounter
WHERE DATE_PART('day', dischtime - admittime) < 2 -- relevantPeriod in days
UNION
DISTINCT
/*
 Definitions:
 Encounter with ICU Location Stay 1 Day or More
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
    where exists (
        QualifyingEncounter.facilityLocations Location
        where Location.code in "Intensive Care Unit"
            and Global."LengthInDays" ( Location.locationPeriod ) >= 1
            and Location.locationPeriod starts
                during Interval[start of QualifyingEncounter.relevantPeriod,
                                TJC."TruncateTime" ( start of QualifyingEncounter.relevantPeriod + 2 days ) ) )
 // Note:
    "Intensive Care Unit" excludes concepts that represent neonatal intensive care units (NICU).
    Location.locationPeriod is the difference between the start and end times of the location.
 */
SELECT *
FROM encounter_without_vte_or_obstetrical_diagnosis AS qualifyingencounter
WHERE EXISTS (SELECT hadm_id
              FROM mimiciii.icustays AS location
              WHERE location.hadm_id = qualifyingencounter.hadm_id
                AND UPPER(first_careunit) != 'NICU'
                AND los >= 1 -- length of stay in days
                  -- locationPeriod starts >= start of Encounter.relevantPeriod and < start + 2 days
                AND (location.intime >= qualifyingencounter.admittime AND
                     location.intime < DATE_TRUNC('day', qualifyingencounter.admittime) + INTERVAL '2 day'))
UNION
DISTINCT
/*
 Definitions:
 Encounter with Principal Diagnosis of Mental Disorder or Stroke
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
    where exists (
        QualifyingEncounter.diagnoses EncounterDiagnoses
        where EncounterDiagnoses.rank = 1
            and ( EncounterDiagnoses.code in "Mental Health Diagnoses"
                or EncounterDiagnoses.code in "Hemorrhagic Stroke"
                or EncounterDiagnoses.code in "Ischemic Stroke") )
 */
SELECT *
FROM encounter_without_vte_or_obstetrical_diagnosis AS qualifyingencounter
WHERE EXISTS (SELECT hadm_id
              FROM mimiciii.diagnoses_icd AS encounterdiagnoses
              WHERE encounterdiagnoses.hadm_id = qualifyingencounter.hadm_id
                AND encounterdiagnoses.seq_num = 1 -- rank
                AND icd9_code IN (SELECT icd9_code
                                  FROM value_set.mental_health_diagnoses
                                  UNION
                                  DISTINCT
                                  SELECT icd9_code
                                  FROM value_set.hemorrhagic_stroke
                                  UNION
                                  DISTINCT
                                  SELECT icd9_code
                                  FROM value_set.ischemic_stroke))
UNION
DISTINCT
/*
 Definitions:
 Encounter with Principal Procedure of SCIP VTE Selected Surgery
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
    with ( "SCIP VTE Selected Surgery" Procedure
            where Procedure.rank = 1 ) SelectedSCIPProcedure
        such that Global."NormalizeInterval" ( SelectedSCIPProcedure.relevantDatetime, SelectedSCIPProcedure.relevantPeriod )
            during QualifyingEncounter.relevantPeriod
 // Note:
    relevant dateTime references the time the procedure is performed when the procedure occurs at a single point in time.
    relevantPeriod references a start and stop time for a procedure that occurs over a time interval.
    Mimic-III does not store either attributes, so it is assumed that the procedure is performed during the encounter relevantPeriod.

 SCIP VTE Selected Surgery
    ["Procedure, Performed": "General Surgery"]
    union ["Procedure, Performed": "Gynecological Surgery"]
    union ["Procedure, Performed": "Hip Fracture Surgery"]
    union ["Procedure, Performed": "Hip Replacement Surgery"]
    union ["Procedure, Performed": "Intracranial Neurosurgery"]
    union ["Procedure, Performed": "Knee Replacement Surgery"]
    union ["Procedure, Performed": "Urological Surgery"]
 // Note:
    'SCIP' stands for Surgical Care Improvement Project
 */
SELECT qualifyingencounter.*
FROM encounter_without_vte_or_obstetrical_diagnosis           AS qualifyingencounter
JOIN (SELECT *
      FROM mimiciii.procedures_icd AS procedure
      WHERE seq_num = 1 -- rank
        AND icd9_code IN (SELECT icd9_code
                          FROM value_set.general_surgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.gynecological_surgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.hip_fracture_surgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.hip_replacement_surgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.intracranial_neurosurgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.knee_replacement_surgery
                          UNION
                          DISTINCT
                          SELECT icd9_code
                          FROM value_set.urological_surgery)) AS selectedscipprocedure
     ON qualifyingencounter.hadm_id = selectedscipprocedure.hadm_id
UNION
DISTINCT
/*
 Definitions:
 Encounter with Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
    with "Intervention Comfort Measures" ComfortMeasures
        such that Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod),
                           ComfortMeasures.authorDatetime)
            during day of VTE."FromDayOfStartOfHospitalizationToDayAfterAdmission" ( QualifyingEncounter )
 // Note:
    No comfort measures are found in the mimic-iii database.
 */
SELECT qualifyingencounter.*
FROM encounter_without_vte_or_obstetrical_diagnosis AS qualifyingencounter
JOIN value_set.comfort_measures                     AS comfortmeasures
     ON qualifyingencounter.hadm_id = comfortmeasures.hadm_id
UNION
DISTINCT
/*
 Definitions:
 Encounter with Intervention Comfort Measures on Day of or Day After Procedure
    from
         VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
         ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
         "Intervention Comfort Measures" ComfortMeasures
    where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod )
            ends 1 day after day of start of QualifyingEncounter.relevantPeriod
        and Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod),
                     ComfortMeasures.authorDatetime)
            during day of TJC."CalendarDayOfOrDayAfter" (end of
                Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
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