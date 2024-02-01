/*
 Recreate materialized view for patient ethnicity codes.
 value set oid: 2.16.840.1.114222.4.11.837
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.114222.4.11.837/expansion/eCQM%20Update%202022-05-05
 Code System: CDCREC
 Definition version: 20121025
 Inclusion: NA
 Exclusion: NA
 Note: no results found for this value set because MIMIC cleanse it to protect identity.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.ethnicity;
CREATE MATERIALIZED VIEW value_set.ethnicity AS
SELECT NULL AS ethnicity;
