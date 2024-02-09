CREATE OR REPLACE VIEW qdm.encounter_performed_observation_services AS
SELECT *
FROM qdm.encounters enc
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(enc.diagnoses) AS diag
              WHERE diag ->> 'code' IN (SELECT code FROM cql.get_source_icd9('observation_services')))
UNION
SELECT DISTINCT enc.*
FROM qdm.encounters     enc
JOIN mimiciii.cptevents cpt ON enc.hadm_id = cpt.hadm_id
WHERE cpt.cpt_cd IN (SELECT code FROM cql.get_source_cpt('observation_services'));

COMMENT ON VIEW qdm.encounter_performed_observation_services IS '
QDM Data Element
    Encounter
        Encounter Performed
            Observation Services

Note: From CMS (2021)';

