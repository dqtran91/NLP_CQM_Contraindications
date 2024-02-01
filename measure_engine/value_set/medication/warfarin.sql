/*
 Recreate materialized view for medications that are warfarin.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.232
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.232/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Code System: RXNORM
 Inclusion: Includes concepts that represent a medication for oral forms of warfarin.
 Exclusion: No exclusions
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.warfarin;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.warfarin AS
SELECT DISTINCT hadm_id
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%warfarin%'
   OR LOWER(drug_name_poe) LIKE '%warfarin%'
   OR LOWER(drug_name_generic) LIKE '%warfarin%';