/*
 Clinical Focus: The purpose of this value set is to represent concepts for a medication administered by
    subcutaneous route.
 Value Set OID: 2.16.840.1.113883.3.117.1.7.1.223
 URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.223/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition version: 20210220
 Data Element Scope: This value set may use a model element related to Medication.
 Inclusion: Includes concepts that identify a procedure of a medication given subcutaneously.
 Exclusion: No exclusions.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.subcutaneous;
CREATE MATERIALIZED VIEW value_set.subcutaneous AS
SELECT DISTINCT route
FROM mimiciii.prescriptions
WHERE UPPER(route) IN ('SC', 'SUBCUT');