/*
 Encounter Less Than 2 Days
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
  where Global."LengthInDays" ( QualifyingEncounter.relevantPeriod ) < 2
 */

SELECT *
FROM vte.encounter_with_age_range_and_without_vte_or_obstetric_conds AS qualifying_encounter
WHERE global.length_in_days(relevant_period) < 2 -- relevantPeriod in days