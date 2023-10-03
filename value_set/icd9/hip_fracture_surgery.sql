/*
 Recreate materialized view for hip-fracture-surgery icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.258
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.258/expansion/
 Inclusion: Includes concepts that represent a procedure for hip fracture surgery.
 Exclusion: No exclusions.
 note: Because both the inclusion and exclusion criteria are empty, this value set includes codes from 2022 and 2012
 to capture more from the data.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.hip_fracture_surgery;
CREATE MATERIALIZED VIEW value_set.hip_fracture_surgery AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_procedures
WHERE icd9_code IN ('7970',
                    '7971',
                    '7972',
                    '7973',
                    '7974',
                    '7979',
                    '8140',
                    '8147',
                    '8149',
                    '8196');