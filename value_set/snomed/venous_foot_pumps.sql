/*
 Recreate materialized view for venous foot pumps (VFP) codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.230
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.230/expansion/eCQM%20Update%202022-05-05
 Inclusion: Includes concepts that represent a device used for venous thromboembolism (VTE) prophylaxis.
 Exclusion: No exclusions.
 note: This value set use SNOMED CT codes, which are not available in MIMIC-III. Instead, the snomed codes were mapped
 to item-ids in the d_items table by examining the description of both and finding the closest match.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.venous_foot_pumps;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.venous_foot_pumps AS
SELECT DISTINCT *
FROM mimiciii.d_items
WHERE label ILIKE '%foot pump%'