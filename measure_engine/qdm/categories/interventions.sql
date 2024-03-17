CREATE OR REPLACE VIEW qdm.interventions AS
SELECT adm.subject_id,
       adm.hadm_id,
       JSONB_AGG(JSONB_BUILD_OBJECT('code', icd9_code,
                                    'relevant_datetime', NULL,
                                    'relevant_period', NULL,
                                    'author_datetime', NULL)
                 ORDER BY seq_num) AS interventions
FROM mimiciii.admissions    AS adm
JOIN mimiciii.diagnoses_icd AS da ON da.hadm_id = adm.hadm_id
GROUP BY adm.subject_id, adm.hadm_id;

COMMENT ON VIEW qdm.interventions IS '
QDM Category
    Interventions

Note:
    From CMS (2021). MIMIC-III does not stored information for just interventions and so the admissions and diagnosis tables are used (Johnson et al., 2016).
    Also, the relevant_datetime and relevant_period are not stored for interventions (2016). Therefore, these fields are set to NULL.';
