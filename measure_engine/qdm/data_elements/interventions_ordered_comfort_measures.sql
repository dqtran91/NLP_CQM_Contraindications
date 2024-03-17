CREATE OR REPLACE VIEW qdm.interventions_ordered_comfort_measures AS
SELECT io.subject_id,
       io.hadm_id,
       JSONB_AGG(intr ORDER BY intr ->> 'relevant_datetime') AS interventions
FROM qdm.interventions_ordered              AS io,
     JSONB_ARRAY_ELEMENTS(io.interventions) AS intr
WHERE intr ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('comfort_measures'))
GROUP BY io.subject_id, io.hadm_id;

COMMENT ON VIEW qdm.interventions_ordered_comfort_measures IS '
QDM Data Element
    Intervention
        Intervention Ordered
            Comfort Measures

Note: From CMS (2021);';
