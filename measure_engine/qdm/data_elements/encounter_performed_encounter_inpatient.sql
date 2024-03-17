CREATE OR REPLACE VIEW qdm.encounter_performed_encounter_inpatient AS
SELECT *
FROM qdm.encounter_performed;

COMMENT ON VIEW qdm.encounter_performed_encounter_inpatient IS '
QDM Data Element
    Encounter
        Encounter Performed
            Encounter Inpatient

Note:
    From CMS (2021). All MIMIC-III encounters are considered inpatient (Johnson et al., 2016).';
