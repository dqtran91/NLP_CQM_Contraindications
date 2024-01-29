/*
 data_elements.encounter_performed_observation_services

 For official measure calculation, the encounter's relevant period end during the measurement period.
 However, the measurement Period can not be considered because the dates are shifted to protect patient privacy,
 so all encounters are considered.
 */
CREATE OR REPLACE VIEW data_elements.encounter_performed_observation_services AS
SELECT *
FROM qdm.encounters encounter_performed
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(encounter_performed.diagnoses) AS encounter_diagnoses
              WHERE encounter_diagnoses ->> 'code' IN (SELECT source_code
                                                       FROM value_set.observation_services
                                                       WHERE source_system = 'http://hl7.org/fhir/sid/icd-9-cm'))
UNION
SELECT DISTINCT enc.*
FROM qdm.encounters     enc
JOIN mimiciii.cptevents cpt ON enc.hadm_id = cpt.hadm_id
WHERE cpt.cpt_cd IN
      (SELECT source_code FROM value_set.observation_services WHERE source_system = 'current procedural terminology')


/*
worksheet

SELECT COUNT(DISTINCT hadm_id), 'qdm.encounters' AS type
FROM qdm.encounters
union
SELECT COUNT(DISTINCT hadm_id), 'observation' AS type
FROM data_elements.encounter_performed_observation_services
union
SELECT COUNT(DISTINCT enc.hadm_id), 'inpatient' AS type
FROM qdm.encounters     enc
JOIN mimiciii.cptevents cpt ON enc.hadm_id = cpt.hadm_id
WHERE cpt.cpt_cd IN
      (SELECT source_code FROM value_set.encounter_inpatient WHERE source_system = 'current procedural terminology');

SELECT (34946 + 5750 + 187) AS code_encounters, 58976 AS total

 */