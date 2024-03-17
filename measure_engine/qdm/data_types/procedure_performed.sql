CREATE OR REPLACE VIEW qdm.procedure_performed AS
SELECT *
FROM qdm.procedures;

COMMENT ON VIEW qdm.procedure_performed IS '
QDM Data Type
    Procedure
        Procedure Performed
            General or Neuraxial Anesthesia

Note: From CMS (2021)';
