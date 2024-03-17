CREATE OR REPLACE VIEW qdm.procedure_performed_app_of_intermittent_pneu_compress_devices AS
SELECT pp.subject_id,
       pp.hadm_id,
       JSONB_AGG(proc ORDER BY proc ->> 'rank') AS procedures
FROM qdm.procedure_performed          AS pp,
     JSONB_ARRAY_ELEMENTS(pp.procedures) AS proc
WHERE proc ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('application_of_intermittent_pneumatic_compression_devices'))
GROUP BY pp.subject_id, pp.hadm_id;;

COMMENT ON VIEW qdm.procedure_performed_app_of_intermittent_pneu_compress_devices IS '
QDM Data Element
    Procedure
        Procedure Performed
            Application of Intermittent Pneumatic Compression Devices (IPC)

Note: From CMS (2021)';
