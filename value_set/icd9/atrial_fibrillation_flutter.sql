/*
 Recreate materialized view for atrial fibrillation/flutter icd9 codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.202
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.202/expansion/eCQM%20Update%202022-05-05
 Inclusion: Includes concepts that identify a diagnosis of a history of atrial fibrillation/flutter or a current finding of atrial fibrillation/flutter.
 Exclusion: No exclusions.
 Definition Version: 20210220
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.atrial_fibrillation_flutter;
CREATE MATERIALIZED VIEW value_set.atrial_fibrillation_flutter AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_diagnoses
WHERE icd9_code IN ('42731',
                    '42732');