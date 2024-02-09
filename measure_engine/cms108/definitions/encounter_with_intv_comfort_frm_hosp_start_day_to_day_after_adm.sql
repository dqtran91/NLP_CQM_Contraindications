CREATE OR REPLACE VIEW cms108.encounter_with_intv_comfort_frm_hosp_start_day_to_day_after_adm AS
SELECT qe.*
FROM vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions AS qe
JOIN (SELECT *,
             (intv ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (intv ->> 'relevant_period')::TSRANGE     AS relevant_period,
             (intv ->> 'author_datetime')::TIMESTAMP   AS author_datetime
      FROM cms108.intervention_comfort_measures       icm,
           JSONB_ARRAY_ELEMENTS(icm.interventions) AS intv)             AS cm ON qe.hadm_id = cm.hadm_id
WHERE COALESCE(LOWER(global.normalize_interval(cm.relevant_datetime, cm.relevant_period)), cm.author_datetime) <@
      vte.from_hosp_start_day_to_day_after_admission(ROW (qe.hadm_id, qe.relevant_period));

COMMENT ON VIEW cms108.encounter_with_intv_comfort_frm_hosp_start_day_to_day_after_adm IS '
Encounter with Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
      with "Intervention Comfort Measures" ComfortMeasures
        such that Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod), ComfortMeasures.authorDatetime)during day of VTE."FromDayOfStartOfHospitalizationToDayAfterAdmission" ( QualifyingEncounter )

Note: From CMS108v11 (eCQI, 2023).';
