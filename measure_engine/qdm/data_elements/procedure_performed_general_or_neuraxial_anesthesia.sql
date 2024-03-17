CREATE OR REPLACE VIEW qdm.procedure_performed_general_or_neuraxial_anesthesia AS
SELECT pp.subject_id,
       pp.hadm_id,
       JSONB_AGG(proc ORDER BY proc ->> 'rank') AS procedures
FROM qdm.procedure_performed             AS pp,
     JSONB_ARRAY_ELEMENTS(pp.procedures) AS proc
WHERE proc ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('general_or_neuraxial_anesthesia'))
GROUP BY pp.subject_id, pp.hadm_id;

COMMENT ON VIEW qdm.procedure_performed_general_or_neuraxial_anesthesia IS '
QDM Data Element
    Procedure
        Procedure Performed
            General or Neuraxial Anesthesia

Note: From CMS (2021)';
