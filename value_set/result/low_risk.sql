/*
 Clinical Focus: The purpose of this value set is to describe concepts for an assessment with
    a measurement containing results of 'low.'
 Data Element Scope: This value set may use a model element related to Assessment.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.400
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.400/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition version: 20210220
 Inclusion: Includes concepts that represent an assessment with results of 'low'.
 Exclusion: No exclusions.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.low_risk;
CREATE MATERIALIZED VIEW value_set.low_risk AS
SELECT DISTINCT drg_severity
from drgcodes
where drg_severity in (0,1)