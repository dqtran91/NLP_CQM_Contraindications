CREATE OR REPLACE VIEW qdm.interventions_performed AS
SELECT *
FROM qdm.interventions;

COMMENT ON VIEW qdm.interventions_performed IS '
QDM Data Type
    Intervention
        Intervention Performed

Note: From CMS (2021)';
