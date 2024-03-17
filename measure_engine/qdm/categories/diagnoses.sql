CREATE OR REPLACE VIEW qdm.diagnoses AS
SELECT adm.subject_id,
       adm.hadm_id,
       JSONB_AGG(JSONB_BUILD_OBJECT('code', icd9_code,
                                    'rank', seq_num,
                                    'prevalence_period ', NULL) ORDER BY seq_num) AS diagnoses
FROM mimiciii.admissions    AS adm
JOIN mimiciii.diagnoses_icd AS da ON da.hadm_id = adm.hadm_id
GROUP BY adm.subject_id, adm.hadm_id;

COMMENT ON VIEW qdm.diagnoses IS '
QDM Category
    Diagnosis

Note:
    From CMS (2021).';
