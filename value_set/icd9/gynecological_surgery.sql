/*
 Recreate materialized view for gynecological-surgery icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.257
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.257/expansion/
 Inclusion: Includes concepts that represent a procedure for gynecologic surgery.
 Exclusion: No exclusions.
 note: Because both the inclusion and exclusion criteria are empty, this value set includes codes from 2022 and 2012
 to capture more from the data.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.gynecological_surgery;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.gynecological_surgery AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_procedures
WHERE icd9_code IN ('4576',
                    '4840',
                    '4843',
                    '4849',
                    '4850',
                    '4852',
                    '4861',
                    '4862',
                    '4863',
                    '4864',
                    '4865',
                    '4869',
                    '5771',
                    '5779',
                    '5839',
                    '6522',
                    '6529',
                    '6539',
                    '6541',
                    '6549',
                    '6551',
                    '6552',
                    '6561',
                    '6562',
                    '6563',
                    '6564',
                    '6602',
                    '6621',
                    '6622',
                    '6629',
                    '6631',
                    '6632',
                    '6639',
                    '664',
                    '6651',
                    '6652',
                    '6661',
                    '6662',
                    '6663',
                    '6669',
                    '6692',
                    '6697',
                    '674',
                    '6831',
                    '6839',
                    '6841',
                    '6849',
                    '6851',
                    '6859',
                    '6861',
                    '6869',
                    '6871',
                    '6879',
                    '688',
                    '689',
                    '6919',
                    '6929',
                    '6998',
                    '704',
                    '743');