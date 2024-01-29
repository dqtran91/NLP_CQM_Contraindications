/*
 data_elements.encounter_performed_emergency_department_visits

 For official measure calculation, the encounter's relevant period end during the measurement period.
 However, the measurement Period can not be considered because the dates are shifted to protect patient privacy,
 so all encounters are considered.
 */
CREATE OR REPLACE VIEW data_elements.encounter_performed_emergency_department_visits AS
SELECT *
FROM qdm.encounters AS enc
WHERE enc.hadm_id IN (SELECT hadm_id FROM mimiciii.admissions WHERE admission_type = 'EMERGENCY');



