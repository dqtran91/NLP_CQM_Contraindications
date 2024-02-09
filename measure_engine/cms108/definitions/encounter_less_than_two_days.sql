CREATE OR REPLACE VIEW cms108.encounter_less_than_two_days AS
SELECT *
FROM vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions AS qualifying_encounter
WHERE global.length_in_days(relevant_period) < 2;

COMMENT ON VIEW cms108.encounter_less_than_two_days IS '
Encounter Less Than 2 Days
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
     where Global."LengthInDays" ( QualifyingEncounter.relevantPeriod ) < 2

Note: From CMS108v11 (eCQI, 2023).';