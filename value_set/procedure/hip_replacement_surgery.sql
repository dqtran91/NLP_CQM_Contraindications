/*
 Recreate materialized view for hip-replacement-surgery procedure codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.259
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.259/expansion/
 Code System: ICD-9-PCS
 Inclusion: Includes concepts that represent a procedure for a total hip replacement.
 Exclusion: No exclusions.
 note: Because both the inclusion and exclusion criteria are empty, this value set includes codes from 2022 and 2012
 to capture more from the data.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.hip_replacement_surgery;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.hip_replacement_surgery AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_procedures
WHERE icd9_code IN ('0070',
                    '0071',
                    '0072',
                    '0073',
                    '0074',
                    '0075',
                    '0076',
                    '0077',
                    '0080',
                    '0081',
                    '0082',
                    '0083',
                    '0084',
                    '0085',
                    '0086',
                    '0087',
                    '7609',
                    '7970',
                    '8000',
                    '8001',
                    '8002',
                    '8003',
                    '8004',
                    '8005',
                    '8006',
                    '8007',
                    '8008',
                    '8009',
                    '8010',
                    '8015',
                    '8054',
                    '8151',
                    '8152',
                    '8153',
                    '8196',
                    '8303',
                    '8394',
                    '8459',
                    '8466',
                    '8467',
                    '8468');