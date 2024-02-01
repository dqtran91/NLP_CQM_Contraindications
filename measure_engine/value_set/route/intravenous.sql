/*
 Clinical Focus: The purpose of this value set is to identify concepts of a procedure of medication
    administered intravenously.
 Value Set OID: 2.16.840.1.113883.3.117.1.7.1.222
 URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.222/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition version: 20210220
 Data Element Scope: This value set may use a model element related to Procedure.
 Inclusion: Includes concepts that identify a procedure of a medication given intravenously.
 Exclusion: No exclusions.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.intravenous;
CREATE MATERIALIZED VIEW value_set.intravenous AS
select DISTINCT route
from mimiciii.prescriptions
where UPPER(route) IN ('IV', 'IV BOLUS', 'IV DRIP', 'IVPCA', 'IVS', 'PB');


