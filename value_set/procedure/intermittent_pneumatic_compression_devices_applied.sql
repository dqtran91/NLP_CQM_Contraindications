/*
 Clinical Focus: The purpose of this value set is to identify concepts of the procedure for the application of
    Intermittent Pneumatic Compression Devices (IPC) for venous thromboembolism (VTE) prophylaxis.
 value set oid: 2.16.840.1.113762.1.4.1110.65
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.65/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition Version: 20220212
 Inclusion: Includes concepts that represent the procedure of the application of a device used for
    venous thromboembolism (VTE) prophylaxis.
 Exclusion: No exclusions.
 note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
 to the d_icd_procedures table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.intermittent_pneumatic_compression_devices_applied;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.intermittent_pneumatic_compression_devices_applied AS
SELECT DISTINCT p.hadm_id
FROM mimiciii.procedures_icd p
JOIN mimiciii.d_icd_procedures d ON p.icd9_code = d.icd9_code
WHERE d.long_title ILIKE '%pneumo boots%'
OR d.short_title ILIKE '%pneumo boots%'