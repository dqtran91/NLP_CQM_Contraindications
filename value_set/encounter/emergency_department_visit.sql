/*
 Recreate materialized view for emergency-department-visit value-set codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.292
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.292/expansion/eCQM%20Update%202022-05-05
 Code system: SNOMEDCT
 Definition version: 20210611
 Inclusion: Includes concepts that represent an encounter occurring in the emergency department (ED).
 Exclusion: Excludes concepts that represent services not performed in the emergency department, including critical care and observation services.
 note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so the admissions table was used instead.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.emergency_department_visit;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.emergency_department_visit AS
SELECT DISTINCT admission_type
FROM mimiciii.admissions
WHERE UPPER(admission_type) = 'EMERGENCY';