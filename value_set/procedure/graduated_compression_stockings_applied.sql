/*
 Clinical Focus: The purpose of this value set is to identify concepts of the procedure for the application of
    graduated compression stockings (GCS) for venous thromboembolism (VTE) prophylaxis.
 Value Set OID: 2.16.840.1.113762.1.4.1110.66
 Url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.66/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Inclusion: Includes concepts that represent the procedure of the application of a device used for
    venous thromboembolism (VTE) prophylaxis.
 Exclusion: No exclusions.
 Note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
    to d_icd_procedures table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.graduated_compression_stockings_applied;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.graduated_compression_stockings_applied AS
SELECT DISTINCT *
FROM mimiciii.d_icd_procedures
WHERE long_title ILIKE '%graduated_compression%'
   OR short_title ILIKE '%graduated_compression%'
