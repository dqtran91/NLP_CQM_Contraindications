/*
 Recreate materialized view for medications that are direct thrombin inhibitor.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.205
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.205/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that represent a medication that is a direct thrombin inhibitor.
 Exclusion: No exclusions
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.direct_thrombin_inhibitor;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.direct_thrombin_inhibitor AS
SELECT DISTINCT drug
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%dabigatran%'
   OR LOWER(drug_name_poe) LIKE '%dabigatran%'
   OR LOWER(drug_name_generic) LIKE '%dabigatran%'
   OR LOWER(drug) LIKE '%etexilate%'
   OR LOWER(drug_name_poe) LIKE '%etexilate%'
   OR LOWER(drug_name_generic) LIKE '%etexilate%'
   OR LOWER(drug) LIKE '%argatroban%'
   OR LOWER(drug_name_poe) LIKE '%argatroban%'
   OR LOWER(drug_name_generic) LIKE '%argatroban%'
   OR LOWER(drug) LIKE '%bivalirudin%'
   OR LOWER(drug_name_poe) LIKE '%bivalirudin%'
   OR LOWER(drug_name_generic) LIKE '%bivalirudin%';