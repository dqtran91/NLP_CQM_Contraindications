/*
 Clinical Focus: The purpose of this value set is to represent concepts for a device of
    graduated compression stocking devices used to prevent venous thromboembolism (VTE) in patients.
 Value Set OID: 2.16.840.1.113883.3.117.1.7.1.256
 Url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.256/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Inclusion: Includes concepts that represent a device for graduated compression stockings.
 Exclusion: No exclusions.
 Note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
    to item-ids in the d_items table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.graduated_compression_stockings_ordered;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.graduated_compression_stockings_ordered AS
SELECT DISTINCT *
FROM mimiciii.d_items
WHERE label ILIKE '%compression%' -- graduated or pneumatic compression devices value set
   OR label ILIKE '%stocking%'    -- graduated or pneumatic compression devices value set
   OR label ILIKE '%hosiery%'
   OR label ILIKE '%anti embolic device%';