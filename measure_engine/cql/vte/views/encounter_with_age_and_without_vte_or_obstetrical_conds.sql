/*
 VTE.Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions

 For official measure calculation, the age range is 18 years and older.
 Age cannot be calculated because MIMIC shifted the date of birth to protect patient privacy
 */
CREATE OR REPLACE VIEW vte.encounter_with_age_range_and_without_vte_or_obstetric_conds AS
SELECT *
FROM global.inpatient_encounter
INTERSECT
SELECT *
FROM vte.admission_without_vte_or_obstetrical_conditions;

