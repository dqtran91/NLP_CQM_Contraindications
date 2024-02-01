/*
 Recreate materialized view for laboratory test for international normalized ratio.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.213
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.213/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Code System: LOINC
 Inclusion: Includes concepts that represent a laboratory test of INR (International Normalized Ratio).
 Exclusion: No exclusions.
 note: There was no results in mimic for this code.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.international_normalized_ratio;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.international_normalized_ratio AS
SELECT DISTINCT loinc_code
FROM mimiciii.d_labitems
WHERE loinc_code IN ('34714-6', '38875-1', '46418-0', '52129-4', '6301-6');
