CREATE OR REPLACE VIEW qdm.encounter_performed_encounter_inpatient AS
SELECT *
FROM qdm.encounters;

COMMENT ON VIEW qdm.encounter_performed_encounter_inpatient IS '
QDM Data Element
    Encounter
        Encounter Performed
            Encounter Inpatient

Note: From CMS (2021)';