CREATE OR REPLACE VIEW qdm.diagnosis_venous_thromboembolism AS
SELECT d.subject_id,
       d.hadm_id,
       JSONB_AGG(diag ORDER BY diag->>'rank') AS diagnoses
FROM qdm.diagnoses AS d,
     JSONB_ARRAY_ELEMENTS(d.diagnoses) AS diag
WHERE diag ->> 'code' IN (SELECT code FROM cql.get_standard_icd9('venous_thromboembolism'))
GROUP BY d.subject_id, d.hadm_id;

COMMENT ON VIEW qdm.diagnosis_venous_thromboembolism IS '
QDM Data Element
    Diagnosis
        Venous Thromboembolism

Note: From CMS (2021)';
