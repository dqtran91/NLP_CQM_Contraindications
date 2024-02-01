/*
 Initial Population:

 VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions"

 Reference:
    Electronic Clinical Quality Improvement. (May 17, 2023). Venous Thromboembolism Prophylaxis. Population Criteria section. https://ecqi.healthit.gov/sites/default/files/ecqm/measures/CMS108v11.html
 */
CREATE VIEW cms108.initial_population AS
SELECT *
FROM vte.encounter_with_age_range_and_without_vte_or_obstetric_conds
