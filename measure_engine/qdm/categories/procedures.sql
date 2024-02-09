CREATE OR REPLACE VIEW qdm.procedures AS
SELECT hadm_id,
       subject_id,
       JSONB_AGG(JSONB_BUILD_OBJECT('code', icd9_code, 'rank', seq_num, 'relevant_datetime', NULL, 'relevant_period', NULL)
                 ORDER BY seq_num) AS procedures
FROM mimiciii.procedures_icd
GROUP BY hadm_id, subject_id;

COMMENT ON VIEW qdm.procedures IS '
QDM Category
    Procedures

Note:
    From CMS (2021). MIMIC-III does not store the relevant_datetime and the relevant_period for procedures (Johnson et al., 2016).
    The datetimeevents and chartevents tables does not link reliably back to procedures_icd. Therefore, these fields are set to NULL.
    ';
