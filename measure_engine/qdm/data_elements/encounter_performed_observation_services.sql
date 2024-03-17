CREATE OR REPLACE VIEW qdm.encounter_performed_observation_services AS
SELECT ep.subject_id,
       ep.hadm_id,
       ep.relevant_period,
       ep.admission_type,
       JSONB_AGG(diag ORDER BY diag ->> 'rank') AS diagnoses,
       ep.facility_locations
FROM qdm.encounter_performed            AS ep,
     JSONB_ARRAY_ELEMENTS(ep.diagnoses) AS diag
WHERE diag ->> 'code' IN (SELECT code FROM cql.get_source_icd9('observation_services'))
GROUP BY ep.subject_id, ep.hadm_id, ep.relevant_period, ep.admission_type, ep.facility_locations
UNION DISTINCT
SELECT DISTINCT enc.*
FROM qdm.encounter_performed enc
JOIN mimiciii.cptevents      cpt ON enc.hadm_id = cpt.hadm_id
WHERE cpt.cpt_cd IN (SELECT code FROM cql.get_source_cpt('observation_services'));

COMMENT ON VIEW qdm.encounter_performed_observation_services IS '
QDM Data Element
    Encounter
        Encounter Performed
            Observation Services

Note: From CMS (2021)';
