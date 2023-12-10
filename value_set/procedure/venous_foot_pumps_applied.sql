/*
 Clinical Focus: The purpose of this value set is to identify concepts for a device for a venous pump applied for
 venous thromboembolism (VTE) prophylaxis.
 value set oid: 2.16.840.1.113762.1.4.1110.64
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.64/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition Version: 20220212
 Inclusion: Includes concepts that represent a device used for venous thromboembolism (VTE) prophylaxis.
 Exclusion: No exclusions.
 note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
 to the d_icd_procedures table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.venous_foot_pumps_ordered;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.venous_foot_pumps_ordered AS
SELECT DISTINCT *
FROM mimiciii.d_icd_procedures
WHERE long_title ILIKE '%foot pump%'
  AND short_title ILIKE '%foot pump%';