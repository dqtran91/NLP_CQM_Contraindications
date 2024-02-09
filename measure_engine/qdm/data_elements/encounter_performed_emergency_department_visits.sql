CREATE OR REPLACE VIEW qdm.encounter_performed_emergency_department_visits AS
SELECT *
FROM qdm.encounters AS enc
WHERE enc.hadm_id IN (SELECT hadm_id FROM mimiciii.admissions WHERE admission_type = 'EMERGENCY');

COMMENT ON VIEW qdm.encounter_performed_emergency_department_visits IS '
QDM Data Element
    Encounter
        Encounter Performed
            Emergency Department Visits

Note: From CMS (2021)';
