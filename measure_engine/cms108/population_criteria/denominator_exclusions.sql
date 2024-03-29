CREATE OR REPLACE VIEW cms108.denominator_exclusions AS
SELECT *
FROM cms108.encounter_less_than_two_days
/*
UNION DISTINCT
SELECT *
FROM cms108.enc_wth_icu_location_stay_one_day_or_more -- removed because it would removed 76% of the population
 */
UNION DISTINCT
SELECT *
FROM cms108.enc_wth_principal_diagnosis_of_mental_disorder_or_stroke
UNION DISTINCT
SELECT *
FROM cms108.enc_wth_principal_procedure_of_scip_vte_selected_surgery
UNION DISTINCT
SELECT *
FROM cms108.enc_wth_intv_comfort_meas_from_hosp_start_day_to_day_after_adm
UNION DISTINCT
SELECT *
FROM cms108.enc_wth_intv_comfort_meas_on_day_or_after_proc;

COMMENT ON VIEW cms108.denominator_exclusions IS '
Denominator Exclusions
    "Encounter Less Than 2 Days"
      union "Encounter with ICU Location Stay 1 Day or More"
      union "Encounter with Principal Diagnosis of Mental Disorder or Stroke"
      union "Encounter with Principal Procedure of SCIP VTE Selected Surgery"
      union "Encounter with Intervention Comfort Measures From Day of Start of Hospitalization To Day After Admission"
      union "Encounter with Intervention Comfort Measures on Day of or Day After Procedure"

 Note:
    From CMS108v11 (eCQI, 2023). "Encounter with ICU Location Stay 1 Day or More" was removed because it would remove 76% of the population.
    It would make the measure not feasible to implement. Check enc_wth_icu_location_stay_one_day_or_more.sql for more details.';
