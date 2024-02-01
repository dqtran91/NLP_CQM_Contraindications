/*
 Recreate materialized view for medications to identify injectable factor Xa inhibitors for VTE.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.211
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.211/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Code System: RXNORM
 Inclusion: Includes concepts that represent a medication that is an injectable factor Xa inhibitor.
 Exclusion: No exclusions.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.injectable_factor_xa_inhibitors_vte;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.injectable_factor_xa_inhibitors_vte AS
SELECT distinct hadm_id
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%fondaparinux%'
   OR LOWER(drug_name_poe) LIKE '%fondaparinux%'
   OR LOWER(drug_name_generic) LIKE '%fondaparinux%';