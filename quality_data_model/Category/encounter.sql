/*
 QDM Category: Encounter
 */
CREATE OR REPLACE VIEW QDM.Encounter AS
WITH DiagnosesAgg AS (SELECT hadm_id,
                             JSONB_AGG(JSONB_BUILD_OBJECT('code', icd9_code, 'rank', seq_num)
                                       ORDER BY seq_num) AS diagnoses
                      FROM mimiciii.diagnoses_icd
                      GROUP BY hadm_id),
     TransfersAgg AS (SELECT hadm_id,
                             JSONB_AGG(JSONB_BUILD_OBJECT('code', COALESCE(curr_wardid, prev_wardid), 'locationPeriod',
                                                          TSRANGE(intime, COALESCE(outtime, intime), '[]'))
                                       ORDER BY intime) AS facilityLocation
                      FROM mimiciii.transfers AS tra
                      GROUP BY hadm_id)
SELECT adm.subject_id,
       adm.hadm_id,
       TSRANGE(LEAST(adm.admittime, adm.dischtime), adm.dischtime, '[]') AS relevantPeriod,
       da.diagnoses,
       ta.facilityLocation,
       NULL                                                              AS authorDatetime -- no similar column in MIMIC-III
FROM mimiciii.admissions AS adm
JOIN DiagnosesAgg        AS da ON da.hadm_id = adm.hadm_id
JOIN TransfersAgg        AS ta ON ta.hadm_id = adm.hadm_id
GROUP BY adm.subject_id, adm.hadm_id, adm.admittime, adm.dischtime, da.diagnoses, ta.facilityLocation;
