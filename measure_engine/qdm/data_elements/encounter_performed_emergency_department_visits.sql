CREATE OR REPLACE VIEW qdm.encounter_performed_emergency_department_visits AS
SELECT *
FROM qdm.encounter_performed
WHERE admission_type IN (SELECT code FROM cql.get_source_mimiciii('emergency_department_visit'));

COMMENT ON VIEW qdm.encounter_performed_emergency_department_visits IS '
QDM Data Element
    Encounter
        Encounter Performed
            Emergency Department Visits

Note: From CMS (2021)';
