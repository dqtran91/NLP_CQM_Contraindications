/*
 Recreate materialized view for medications that are rivaroxaban for VTE.
 value set oid: 2.16.840.1.113762.1.4.1110.50
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.50/expansion/eCQM%20Update%202022-05-05
 Definition version: 20220219
 Code System: RXNORM
 Inclusion: Includes concepts that represent a medication for oral forms of rivaroxaban.
 Exclusion: No exclusions
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.rivaroxaban_vte;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.rivaroxaban_vte AS
SELECT DISTINCT drug
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%rivaroxaban%'
   OR LOWER(drug_name_poe) LIKE '%rivaroxaban%'
   OR LOWER(drug_name_generic) LIKE '%rivaroxaban%';