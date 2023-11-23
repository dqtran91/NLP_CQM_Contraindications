/*
 Recreate materialized view for venous thromboembolism (VTE) icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.279
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.279/expansion/MU2%20Update%202012-10-25
 Inclusion: Includes concepts that represent a diagnosis of proximal venous thromboembolism (VTE) and
            pulmonary embolism of popliteal veins, femoral/superficial femoral veins, deep femoral veins,
            ileofemoral veins, iliac veins and inferior vena cava.
 Exclusion: Excludes concepts that represent a diagnosis of venous thromboembolism (VTE) that is chronic or history of,
            located in the upper extremities, and veins not listed in the inclusion criteria.
 Definition Version: 20121025
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.venous_thromboembolism;
CREATE MATERIALIZED VIEW value_set.venous_thromboembolism AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_diagnoses
WHERE icd9_code IN (
'41511',
'41513',
'41519',
'45111',
'45119',
'4512',
'45181',
'4519',
'4532',
'45340',
'45341',
'45387',
'45389',
'4539'
)