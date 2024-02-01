/*
 Clinical Focus: The purpose of this value set is to represent concepts of devices using
    intermittent pneumatic compression devices for venous thromboembolism (VTE) prophylaxis.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.214
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.214/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Inclusion: Includes concepts that represent a device for intermittent pneumatic compression.
 Exclusion: No exclusions.
 note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
 to item-ids in the d_items table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.intermittent_pneumatic_compression_devices_ordered;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.intermittent_pneumatic_compression_devices_ordered AS
SELECT DISTINCT *
FROM mimiciii.d_items
WHERE label ILIKE '%pneumo boots%'