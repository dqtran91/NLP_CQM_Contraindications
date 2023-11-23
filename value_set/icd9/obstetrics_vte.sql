/*
 Recreate materialized view for obstetrics-vte icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.264
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.264/expansion/MU2%20Update%202012-10-25
 Inclusion: Includes concepts that represent a diagnosis for venous thromboembolism related to pregnancy or obstetrics
 Exclusion: No exclusions.
 Definition Version: 20121025
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.obstetrics_vte;
CREATE MATERIALIZED VIEW value_set.obstetrics_vte AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_diagnoses
WHERE icd9_code IN (
'63460',
'63461',
'63462',
'63560',
'63561',
'63562',
'63660',
'63661',
'63662',
'63760',
'63761',
'63762',
'6386',
'6396',
'67130',
'67131',
'67133',
'67140',
'67142',
'67144',
'67150',
'67151',
'67152',
'67153',
'67154',
'67190',
'67191',
'67192',
'67193',
'67194',
'67320',
'67321',
'67322',
'67323',
'67324')
