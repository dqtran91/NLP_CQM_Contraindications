/*
 In Mimic-III, palliative care is treated the same as comfort care.
 TODO: add a comfort care option when running the ETL.
 */

TRUNCATE TABLE value_set.comfort_measures;

INSERT
INTO value_set.comfort_measures (source_system, source_version, source_code, source_display)
SELECT DISTINCT 'http://hl7.org/fhir/sid/icd-9-cm' AS source_system,
                '2001-2012'                        AS source_version,
                icd9_code                          AS source_code,
                long_title                         AS source_display
FROM mimiciii.d_icd_diagnoses
WHERE LOWER(long_title) = 'encounter for palliative care'