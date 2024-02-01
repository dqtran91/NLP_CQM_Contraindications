CREATE OR REPLACE VIEW vte.admission_without_vte_or_obstetrical_conditions AS
SELECT *
FROM global.inpatient_encounter AS inpatient_encounter
WHERE NOT EXISTS (SELECT 1
                  FROM JSONB_ARRAY_ELEMENTS(inpatient_encounter.diagnoses) AS encounter_diagnoses
                  WHERE encounter_diagnoses ->> 'code' IN (SELECT code
                                                           FROM cql.get_icd9_code('value_set',
                                                                                  'obstetrical_or_pregnancy_related_conditions')
                                                           UNION
                                                           DISTINCT
                                                           SELECT code
                                                           FROM cql.get_icd9_code('value_set', 'venous_thromboembolism')
                                                           UNION
                                                           DISTINCT
                                                           SELECT code
                                                           FROM cql.get_icd9_code('value_set', 'obstetrics_vte')));
