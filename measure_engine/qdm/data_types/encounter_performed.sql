CREATE OR REPLACE VIEW qdm.encounter_performed AS
SELECT *
FROM qdm.encounters;

COMMENT ON VIEW qdm.encounter_performed IS '
QDM Data Type
    Encounter
        Encounter Performed

Note: From CMS (2021)';
