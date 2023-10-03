/*
 Recreate materialized view for intracranial-neurosurgery icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.260
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.260/expansion/
 Inclusion: Includes concepts that represent a procedure for intracranial neurosurgery.
 Exclusion: No exclusions.
 note: Because both the inclusion and exclusion criteria are empty, this value set includes codes from 2022 and 2012
 to capture more from the data.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.intracranial_neurosurgery;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.intracranial_neurosurgery AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_procedures
WHERE icd9_code IN ('0101',
                    '0109',
                    '0111',
                    '0112',
                    '0113',
                    '0114',
                    '0115',
                    '0118',
                    '0121',
                    '0122',
                    '0123',
                    '0124',
                    '0125',
                    '0128',
                    '0131',
                    '0132',
                    '0139',
                    '0141',
                    '0142',
                    '0151',
                    '0152',
                    '0153',
                    '0159',
                    '016',
                    '0201',
                    '0206',
                    '0207',
                    '0214',
                    '0221',
                    '0222',
                    '0231',
                    '0232',
                    '0233',
                    '0234',
                    '0235',
                    '0239',
                    '0242',
                    '0243',
                    '0293',
                    '0294',
                    '0295',
                    '0301',
                    '1651',
                    '2095',
                    '240',
                    '2412',
                    '244',
                    '247',
                    '2732',
                    '7601',
                    '7609',
                    '7611',
                    '762',
                    '7639',
                    '7645',
                    '8000',
                    '8010',
                    '8030',
                    '8080',
                    '8090',
                    '9359',
                    '9395',
                    '9736',
                    '9923');