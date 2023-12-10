/*
 Recreate materialized view for observation-services value-set codes.
 value set oid: 2.16.840.1.113762.1.4.1111.143
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1111.143/expansion/eCQM%20Update%202022-05-05
 Code system: SNOMEDCT
 Definition version: 20210611
 Inclusion: Includes concepts that represent an encounter for inpatient observation.
 Exclusion: No exclusions.
 note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so the cptevents table was used instead.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.observation_services;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.observation_services AS
SELECT DISTINCT subsectionheader
FROM mimiciii.cptevents
WHERE LOWER(subsectionheader) = 'hospital observation services';

