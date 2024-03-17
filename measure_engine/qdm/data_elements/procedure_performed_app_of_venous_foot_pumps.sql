CREATE OR REPLACE VIEW qdm.procedure_performed_app_of_venous_foot_pumps AS
SELECT pp.subject_id,
       pp.hadm_id,
       JSONB_AGG(proc ORDER BY proc ->> 'rank') AS procedures
FROM qdm.procedure_performed          AS pp,
     JSONB_ARRAY_ELEMENTS(pp.procedures) AS proc
WHERE proc ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('application_of_venous_foot_pumps'))
GROUP BY pp.subject_id, pp.hadm_id;;

COMMENT ON VIEW qdm.procedure_performed_app_of_venous_foot_pumps IS '
QDM Data Element
    Procedure
        Procedure Performed
            Application of Venous Foot Pumps (VFP)

Note: From CMS (2021)';
