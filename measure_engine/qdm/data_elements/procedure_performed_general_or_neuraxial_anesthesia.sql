/*
 QDM data element:
 Procedure, Performed: General or Neuraxial Anesthesia
 */
CREATE OR REPLACE VIEW qdm.procedure_performed_general_or_neuraxial_anesthesia AS
SELECT DISTINCT enc.subject_id,
                enc.hadm_id,
                NULL::TIMESTAMP AS relevant_datetime, -- MIMIC does not have a relevant datetime for procedures
                NULL::TSRANGE   AS relevant_period    -- MIMIC does not have a relevant period for procedures
FROM qdm.encounters AS enc
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(enc.diagnoses) AS encounter_diagnoses
              WHERE encounter_diagnoses ->> 'code' IN
                    (SELECT code FROM cql.get_icd9_code('value_set', 'general_or_neuraxial_anesthesia')))
