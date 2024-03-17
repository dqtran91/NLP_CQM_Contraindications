CREATE OR REPLACE VIEW qdm.procedure_performed_app_of_graduated_compress_stockings AS
SELECT pp.subject_id,
       pp.hadm_id,
       JSONB_AGG(proc ORDER BY proc ->> 'rank') AS procedures
FROM qdm.procedure_performed          AS pp,
     JSONB_ARRAY_ELEMENTS(pp.procedures) AS proc
WHERE proc ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('application_of_graduated_compression_stockings'))
GROUP BY pp.subject_id, pp.hadm_id;;

COMMENT ON VIEW qdm.procedure_performed_app_of_graduated_compress_stockings IS '
QDM Data Element
    Procedure
        Procedure Performed
            Application of Graduated Compression Stockings (GCS)

Note: From CMS (2021)';
