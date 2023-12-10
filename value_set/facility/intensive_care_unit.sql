/*
 Clinical Focus: The purpose of this value set is to represent concepts of inpatient hospitalization encounters.
 Value set OID: 2.16.840.1.113762.1.4.1029.206
 Url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1029.206/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition Version: 20210220
 Inclusion: Includes concepts that represent a location for an adult or pediatric intensive care unit (ICU).
 Exclusion: Excludes concepts that represent neonatal intensive care units (NICU).
 Note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set, so joining
    with the icustays table based on patients and admissions id will filter out the ICU stays.
    Additionally, there is no need for this view, as the icustays is the information needed.
 */
-- DROP MATERIALIZED VIEW IF EXISTS value_set.intensive_care_unit;
-- CREATE MATERIALIZED VIEW value_set.intensive_care_unit AS
SELECT distinct first_careunit
FROM icustays
WHERE UPPER(first_careunit) != 'NICU';
