/*
 Clinical focus: Gender identity restricted to only Male and Female used in administrative situations
 requiring a restriction to these two categories.
 value set oid: 2.16.840.1.113762.1.4.1
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1/expansion/eCQM%20Update%202022-05-05
 Code System: AdministrativeGender
 Definition version: 20150331
 Inclusion: Male and Female only.
 Exclusion: Any gender identity that is not male or female.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.administrative_sex;
CREATE MATERIALIZED VIEW value_set.administrative_sex AS
SELECT DISTINCT gender
FROM mimiciii.patients