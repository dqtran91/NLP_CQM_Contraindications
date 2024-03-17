CREATE OR REPLACE VIEW qdm.diagnosis_atrial_fibrillation_flutter AS
SELECT d.subject_id,
       d.hadm_id,
       JSONB_AGG(diag ORDER BY diag->>'rank') AS diagnoses
FROM qdm.diagnoses AS d,
     JSONB_ARRAY_ELEMENTS(d.diagnoses) AS diag
WHERE diag ->> 'code' IN (SELECT code FROM cql.get_standard_icd9('atrial_fibrillation_or_flutter'))
GROUP BY d.subject_id, d.hadm_id;

COMMENT ON VIEW qdm.diagnosis_atrial_fibrillation_flutter IS '
QDM Data Element
    Diagnosis
        Atrial Fibrillation/Flutter

Note: From CMS (2021)';
