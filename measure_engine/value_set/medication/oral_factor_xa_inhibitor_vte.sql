/*
 Recreate materialized view for medications to identify oral factor Xa inhibitors for VTE.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.211
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.211/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Code System: RXNORM
 Inclusion: Includes concepts that represent a medication that is an oral factor Xa inhibitor.
 Exclusion: Excludes concepts that represent dose forms of factor Xa inhibitors other than oral.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.oral_factor_xa_inhibitors_vte;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.oral_factor_xa_inhibitors_vte AS
SELECT DISTINCT drug
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%apixaban%'
   OR LOWER(drug_name_poe) LIKE '%apixaban%'
   OR LOWER(drug_name_generic) LIKE '%apixaban%'
   OR LOWER(drug) LIKE '%edoxaban%'
   OR LOWER(drug_name_poe) LIKE '%edoxaban%'
   OR LOWER(drug_name_generic) LIKE '%edoxaban%';