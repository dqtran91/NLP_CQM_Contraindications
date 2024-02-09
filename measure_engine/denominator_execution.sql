/**********************************************
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
SELECT *
FROM cms108.encounter_less_than_two_days
/*
UNION
DISTINCT
SELECT *
FROM definition.encounter_with_icu_location_stay_one_day_or_more -- removed because it would removed 82% of the population
 */
UNION
DISTINCT
SELECT *
FROM cms108.encounter_with_principal_diagnosis_of_mental_disorder_or_stroke
UNION
DISTINCT
SELECT *
FROM cms108.encounter_with_principal_procedure_of_scip_vte_selected_surgery
UNION
DISTINCT
SELECT *
FROM cms108.encounter_with_intv_comfort_frm_hosp_start_day_to_day_after_adm
UNION
DISTINCT
SELECT *
FROM cms108.encounter_with_intv_comfort_on_day_of_or_day_after_procedure;


/**********************************************
  Population Criteria:
  Denominator
    "Initial Population"

 **********************************************/
DROP TABLE IF EXISTS denominator;
CREATE TEMP TABLE IF NOT EXISTS denominator AS
SELECT *
FROM vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions
EXCEPT
SELECT *
FROM denominator_exclusions;

SELECT COUNT(*)
FROM denominator_exclusions;
SELECT COUNT(*)
FROM denominator;

