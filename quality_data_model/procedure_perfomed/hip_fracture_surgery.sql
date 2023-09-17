/*
 Recreate table for the icd9 codes for hip fracture surgery.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.258
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.258/expansion/
 note: Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
DROP TABLE IF EXISTS icd9_hip_fracture_surgery;
CREATE TABLE icd9_hip_fracture_surgery AS
SELECT DISTINCT icd9_code
FROM d_icd_procedures
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
CREATE INDEX idx_icd9hipfracturesurgery_icd9code ON icd9_hip_fracture_surgery (icd9_code);
ANALYSE icd9_hip_fracture_surgery;