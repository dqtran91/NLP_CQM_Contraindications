CREATE OR REPLACE VIEW qdm.medication_administered AS
SELECT *
FROM qdm.medications;

COMMENT ON VIEW qdm.medication_administered IS '
QDM Data Type
    Medication
        Medication Administered

Note: From CMS (2021)';

