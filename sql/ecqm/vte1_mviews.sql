/* CMS108v11 */

-- Recreate materialized view for initial population
DROP MATERIALIZED VIEW IF EXISTS vte1_initial_population_mv;
CREATE MATERIALIZED VIEW IF NOT EXISTS vte1_initial_population_mv AS
SELECT DISTINCT ON (a.subject_id, a.hadm_id)
    a.subject_id,
    a.hadm_id,
    a.admittime,
    a.dischtime
FROM admissions          a
LEFT JOIN patients       p ON a.subject_id = p.subject_id
LEFT JOIN diagnoses_icd  d ON a.subject_id = d.subject_id AND a.hadm_id = d.hadm_id
LEFT JOIN procedures_icd p_icd ON a.subject_id = p_icd.subject_id AND a.hadm_id = p_icd.hadm_id
WHERE a.hospital_expire_flag = 0                                              -- Exclude patients who died in the hospital
  AND a.hadm_id NOT IN (SELECT hadm_id FROM vte1_encounters)                  -- Exclude patients with VTE diagnosis
  AND EXTRACT(EPOCH FROM (a.dischtime - a.admittime)) / (60 * 60 * 24) <= 120 -- Length of stay <= 120 days
  AND DATE_PART('year', AGE(a.admittime, p.dob)) >= 18                        -- Patients 18 and above
  AND p_icd.icd9_code NOT IN (SELECT icd9_code FROM obstetrics_icd) -- Exclude obstetrics
;

/* Recreate materialized view for denominator (apply exclusions)
 * No codes for SCIP or comfort measures
 */
DROP MATERIALIZED VIEW IF EXISTS vte1_denominator_mv;
CREATE MATERIALIZED VIEW IF NOT EXISTS vte1_denominator_mv AS
SELECT
    ip.subject_id,
    ip.hadm_id
FROM vte1_initial_population_mv ip
LEFT JOIN icustays              ic ON ip.subject_id = ic.subject_id AND ip.hadm_id = ic.hadm_id
LEFT JOIN diagnoses_icd         d ON ip.subject_id = d.subject_id AND ip.hadm_id = d.hadm_id
WHERE (ic.icustay_id IS NULL OR ic.los < 1)                                               -- Exclude ICU stays of 1 day or more
  AND EXTRACT(EPOCH FROM (ip.dischtime - ip.admittime)) / (60 * 60 * 24) >= 2             -- Exclude encounters less than 2 days
  AND (d.icd9_code NOT IN (SELECT icd9_code FROM mentaldisorders_icd) AND d.seq_num != 1) -- Exclude principal mental disorders diagnosis
  AND (d.icd9_code NOT IN (SELECT icd9_code FROM stroke_icd) AND d.seq_num != 1);         -- Exclude principal stroke diagnosis

-- Create materialized view for numerator (VTE prophylaxis received or reason documented)
DROP MATERIALIZED VIEW IF EXISTS vte1_numerator_mv;
CREATE MATERIALIZED VIEW IF NOT EXISTS vte1_numerator_mv AS
SELECT DISTINCT ON (a.subject_id, a.hadm_id)
    a.subject_id,
    a.hadm_id,
    CASE
        WHEN ce.charttime BETWEEN a.admittime AND (a.admittime + INTERVAL '1 day') THEN TRUE
        ELSE FALSE END AS prophylaxis_status
FROM admissions         a
LEFT JOIN chartevents   ce ON a.subject_id = ce.subject_id AND a.hadm_id = ce.hadm_id
LEFT JOIN prescriptions p ON a.subject_id = p.subject_id AND a.hadm_id = p.hadm_id
WHERE ce.itemid IN (SELECT itemid FROM vte1prophylaxis_items) -- VTE prophylaxis from the d_items table
  AND p.ndc IN (SELECT ndc FROM vte1prophylaxis_prescriptions) -- VTE prophylaxis from the prescription table
;

/* Recreate materialized view for VTE encounters that are in the denominator, but not in the numerators*/
DROP MATERIALIZED VIEW IF EXISTS vte1_encounters_denom_only;
CREATE MATERIALIZED VIEW IF NOT EXISTS vte1_encounters_denom_only AS
SELECT DISTINCT
    d.hadm_id
FROM vte1_denominator_mv    d
LEFT JOIN vte1_numerator_mv n ON d.subject_id = n.subject_id AND d.hadm_id = n.hadm_id
WHERE n.hadm_id IS NULL;


/*Drop all the VTE views*/
DROP MATERIALIZED VIEW IF EXISTS vte1_numerator_mv;
DROP MATERIALIZED VIEW IF EXISTS vte1_denominator_mv;
DROP MATERIALIZED VIEW IF EXISTS vte1_initial_population_mv;
DROP MATERIALIZED VIEW IF EXISTS vte1_encounters_denom_only_mv;

