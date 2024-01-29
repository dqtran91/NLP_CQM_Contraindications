/*
 global.inpatient_encounter

 For official measure calculation, the encounter's relevant period end during the measurement period.
 However, the measurement Period can not be considered because the dates are shifted to protect patient privacy,
 so all encounters are considered.
 */
CREATE OR REPLACE VIEW global.inpatient_encounter AS
SELECT *
FROM qdm.encounters AS encounter_inpatient
WHERE global.length_in_days(relevant_period) <= 120;
