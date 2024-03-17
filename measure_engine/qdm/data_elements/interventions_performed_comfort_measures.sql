CREATE OR REPLACE VIEW qdm.interventions_performed_comfort_measures AS
SELECT ip.subject_id,
       ip.hadm_id,
       JSONB_AGG(intr ORDER BY intr ->> 'relevant_datetime') AS interventions
FROM qdm.interventions_performed            AS ip,
     JSONB_ARRAY_ELEMENTS(ip.interventions) AS intr
WHERE intr ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('comfort_measures'))
GROUP BY ip.subject_id, ip.hadm_id;


COMMENT ON VIEW qdm.interventions_performed_comfort_measures IS '
QDM Data Element
    Intervention
        Intervention Performed
            Comfort Measures

Note: From CMS (2021)';
