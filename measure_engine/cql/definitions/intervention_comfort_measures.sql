/*
 Intervention Comfort Measures:
    ["Intervention, Order": "Comfort Measures"]
    union ["Intervention, Performed": "Comfort Measures"]
 */
CREATE OR REPLACE VIEW definition.intervention_comfort_measures AS
SELECT DISTINCT enc.subject_id,
                enc.hadm_id,
                NULL::TIMESTAMP AS relevant_datetime, -- MIMIC does not have a relevant datetime for interventions
                NULL::TSRANGE   AS relevant_period,   -- MIMIC does not have a relevant period for interventions
                NULL::TIMESTAMP AS author_datetime    -- MIMIC does not have an author datetime for interventions
FROM qdm.encounters AS enc
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(enc.diagnoses) AS encounter_diagnoses
              WHERE encounter_diagnoses ->> 'code' IN (SELECT source_code
                                                       FROM value_set.comfort_measures
                                                       WHERE source_system = 'http://hl7.org/fhir/sid/icd-9-cm'));

