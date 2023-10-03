/*
 Recreate materialized view for hemmorrhagic-stroke icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.212
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.212/expansion/MU2%20Update%202012-10-25
 Inclusion: Includes concepts that represent a diagnosis of hemorrhagic stroke.
 Exclusion: No exclusions.
 Definition Version: 20121025
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.hemmorrhagic_stroke;
CREATE MATERIALIZED VIEW value_set.hemmorrhagic_stroke AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_diagnoses
WHERE icd9_code IN ('430', '431');