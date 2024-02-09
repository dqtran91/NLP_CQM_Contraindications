CREATE OR REPLACE VIEW global.inpatient_encounter AS
SELECT *
FROM qdm.encounter_performed_encounter_inpatient AS enc
WHERE global.length_in_days(relevant_period) <= 120
--   AND UPPER(encounter_inpatient.relevant_period) <@ measurement_period -- not considered because of date shifting
;

COMMENT ON VIEW global.inpatient_encounter IS '
Global.Inpatient Encounter
    ["Encounter, Performed": "Encounter Inpatient"] EncounterInpatient
     where "LengthInDays"(EncounterInpatient.relevantPeriod)<= 120
        and EncounterInpatient.relevantPeriod ends during day of "Measurement Period"

Note:
    From CMS108v11 (eCQI, 2023).
    For official measure calculation, the encounter relevant period end during the measurement period.
    However, the measurement Period can not be considered because the dates are shifted by MIMIC-III to protect patient privacy,
    so all encounters are considered (Johnson et al., 2016).';
