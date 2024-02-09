CREATE OR REPLACE VIEW qdm.interventions_performed_comfort_measures AS
SELECT *
FROM qdm.interventions AS ip
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(ip.interventions) AS inter
              WHERE inter ->> 'code' IN (SELECT code FROM cql.get_source_icd9('comfort_measures')));

COMMENT ON VIEW qdm.interventions_performed_comfort_measures IS '
QDM Data Element
    Intervention
        Intervention Performed
            Comfort Measures

Note: From CMS (2021)';