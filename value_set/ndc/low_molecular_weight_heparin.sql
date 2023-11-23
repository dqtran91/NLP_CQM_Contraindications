/*
 Recreate materialized view for medication for parenteral administration of low molecular weight heparin medications
 used for venous thromboembolism (VTE) prophylaxis.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.219
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.219/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that represent a medication for parenteral administration of low molecular weight heparin.
 Exclusion: No exclusions.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.low_molecular_weight_heparin;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.low_molecular_weight_heparin AS
SELECT DISTINCT drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, ndc, prod_strength, route
FROM mimiciii.prescriptions
WHERE (LOWER(drug) LIKE '%enoxaparin%' OR LOWER(drug_name_poe) LIKE '%enoxaparin%' OR
       LOWER(drug_name_generic) LIKE '%enoxaparin%' OR LOWER(drug) LIKE '%lovenox%' OR
       LOWER(drug_name_poe) LIKE '%lovenox%' OR LOWER(drug_name_generic) LIKE '%lovenox%' OR
       LOWER(drug) LIKE '%dalteparin%' OR LOWER(drug_name_poe) LIKE '%dalteparin%' OR
       LOWER(drug_name_generic) LIKE '%dalteparin%' OR LOWER(drug) LIKE '%fragmin%' OR
       LOWER(drug_name_poe) LIKE '%fragmin%' OR LOWER(drug_name_generic) LIKE '%fragmin%')
  AND LOWER(drug) != 'dobutamine hcl';


