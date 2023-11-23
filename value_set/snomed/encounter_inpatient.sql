/*
 Recreate materialized view for encounter inpatient value-set codes.
 Value set oid: 2.16.840.1.113883.3.666.5.307
 Url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.666.5.307/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210611
 Inclusion: Includes concepts that represent an encounter for inpatient hospitalizations.
 Exclusion: None
 note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so the admissions table was used instead.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.encounter_inpatient;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.encounter_inpatient AS
SELECT DISTINCT admission_type
FROM mimiciii.admissions
WHERE UPPER(admission_type) != 'NEWBORN';