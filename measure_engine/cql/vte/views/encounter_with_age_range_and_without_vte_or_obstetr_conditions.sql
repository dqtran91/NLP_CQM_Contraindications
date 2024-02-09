CREATE OR REPLACE VIEW vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions AS
SELECT *
FROM global.inpatient_encounter
-- WHERE cql.age_in_years_at(LOWER(inpatient_encounter.relevant_period)) >= 18 -- not considered because of date shifting
INTERSECT
SELECT *
FROM vte.admission_without_vte_or_obstetrical_conditions;

COMMENT ON VIEW vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions IS '
VTE.Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions
    ( Global."Inpatient Encounter" InpatientEncounter
        where AgeInYearsAt(date from start of InpatientEncounter.relevantPeriod)>= 18
    )
     intersect "Admission without VTE or Obstetrical Conditions"

Note:
    From CMS108v11 (eCQI, 2023).
    To comply with HIPAA regulations, MIMIC-III randomly distributed shifts the date of birth (DOB) to the following (Johnson et al., 2016):
    - before 1900 for patients older than 89 years old
    - between 2100 - 2200 for patients younger than 89 years old
    This does not make it possible to calculate the exact age of patients, so all patients are assumed to be older than 18 years old.'
