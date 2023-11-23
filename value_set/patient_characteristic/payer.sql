/*
 Clinical Focus: Categories of types of health care payor entities as defined by the US Public Health Data Consortium SOP code system
 value set oid: 2.16.840.1.114222.4.11.3591
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.114222.4.11.3591/expansion/eCQM%20Update%202022-05-05
 Code System: SOP
 Definition version: 20180718
 Inclusion: All codes in the code system
 Exclusion: none
 Note: no results found for this value set because MIMIC cleanse it to protect identity.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.payer;
CREATE MATERIALIZED VIEW value_set.payer AS
SELECT NULL AS payer;