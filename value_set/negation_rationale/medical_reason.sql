/*
 Recreate materialized view for negation-medical-reason value-set codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.473
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.473/expansion/eCQM%20Update%202022-05-05
 CodeSystem: SNOMEDCT
 Definition version: 20220212
 Inclusion: Includes concepts that represent a negation rationale or reason for not providing treatment.
 Exclusion: No exclusions.
 note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so there are no results for this value set.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.medical_reason;
CREATE MATERIALIZED VIEW value_set.medical_reason AS
SELECT NULL AS medical_reason;
