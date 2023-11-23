/*
 Recreate materialized view for medications of unfractionated heparin with strengths that could be used
 for venous thromboembolism (VTE) prophylaxis.
 value set oid: 2.16.840.1.113762.1.4.1045.39
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1045.39/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that represent a medication that could reasonably be used to achieve a dose of at least 5000 units
 when administered subcutaneously.
 Exclusion: Excludes concepts that represent concentrations less than 250 units/mL.
 Note: Heparin flush and heparin lock flush are excluded because they are used  to keep IV catheters open and flowing freely,
 and not for anti-coagulation
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.low_dose_unfractionated_heparin;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.low_dose_unfractionated_heparin AS
SELECT DISTINCT drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, ndc, prod_strength, route
FROM mimiciii.prescriptions
WHERE (LOWER(drug) LIKE '%heparin%' OR LOWER(drug_name_poe) LIKE '%heparin%' OR
       LOWER(drug_name_generic) LIKE '%heparin%')
  AND LOWER(drug) != 'heparin flush crrt (5000 units/ml)'
  AND UPPER(route) = 'SC';


-- select distinct drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, ndc, prod_strength, route,
--                 dose_val_rx, dose_unit_rx, form_val_disp, form_unit_disp
-- from mimiciii.prescriptions
-- WHERE LOWER(drug) LIKE '%heparin%'
--     AND prod_strength = '25,000 unit Premix Bag';