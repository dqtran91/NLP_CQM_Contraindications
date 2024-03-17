CREATE OR REPLACE VIEW qdm.encounters AS
WITH diagnoses_Agg AS (SELECT hadm_id,
                              JSONB_AGG(JSONB_BUILD_OBJECT('code', icd9_code,
                                                           'rank', seq_num)
                                        ORDER BY seq_num) AS diagnoses
                       FROM mimiciii.diagnoses_icd
                       GROUP BY hadm_id),
     transfers_agg AS (SELECT hadm_id,
                              JSONB_AGG(JSONB_BUILD_OBJECT('code', COALESCE(curr_careunit, prev_careunit),
                                                           'location_period', TSRANGE(intime, COALESCE(outtime, intime), '[]'))
                                        ORDER BY intime) AS facility_locations
                       FROM mimiciii.transfers AS tra
                       GROUP BY hadm_id)
SELECT adm.subject_id,
       adm.hadm_id,
       TSRANGE(LEAST(adm.admittime, adm.dischtime), adm.dischtime, '[]') AS relevant_period,
       adm.admission_type,
       da.diagnoses,
       ta.facility_locations
FROM mimiciii.admissions AS adm
JOIN diagnoses_agg       AS da ON da.hadm_id = adm.hadm_id
JOIN transfers_agg       AS ta ON ta.hadm_id = adm.hadm_id
GROUP BY adm.subject_id, adm.hadm_id, admission_type, adm.admittime, adm.dischtime, da.diagnoses, ta.facility_locations;

COMMENT ON VIEW qdm.encounters IS '
QDM Category
    Encounter

Note: From CMS (2021)';
