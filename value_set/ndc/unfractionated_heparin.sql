/*
 Recreate materialized view for medication for continuous infusion of heparin formulations to treat
 venous thromboembolism (VTE).
 value set oid: 2.16.840.1.113883.3.117.1.7.1.218
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.218/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that represent a medication that could be used for continuous infusion of heparin
 and achieve therapeutic levels.
 Exclusion:  Excludes concepts that describe concentrations < 250 UNT/ML (except those representing premixed heparin infusion bags,
 per inclusion criteria).
 Abbreviations: PB means IV piggyback. IP means intraperitoneal. NG means nasogastric. PO means oral. TP means topical or transplacental.
 Note: https://www.fda.gov/drugs/data-standards-manual-monographs/route-administration
 https://madisonmemorial.org/wp-content/uploads/Abbreviation-List-for-Medical-Record-Documentation-V20.pdf
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.unfractionated_heparin;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.unfractionated_heparin AS
SELECT DISTINCT drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, ndc, prod_strength, route
FROM mimiciii.prescriptions
WHERE (LOWER(drug) LIKE '%heparin%' OR LOWER(drug_name_poe) LIKE '%heparin%' OR
       LOWER(drug_name_generic) LIKE '%heparin%')
  AND UPPER(formulary_drug_cd) NOT IN ('AMID200', 'ATRO1I', 'COSO5ES', 'FURO40I',
                                       'HEP1I', 'HEP10UI', 'HEPA10S', 'HEPA10SYR', 'HEPA10SYRN', 'HEPA100SYR',
                                       'HEPAR10I', 'HEPF100I')
  AND UPPER(route) NOT IN ('DIALYS', 'DWELL', 'IP', 'IRR', 'LOCK', 'NG', 'PO', 'TP')
  AND LOWER(drug) NOT IN ('heparin flush', 'heparin flush (1000 units/ml)', 'heparin flush (5000 units/ml)',
                          'heparin flush crrt (5000 units/ml)', 'heparin flush cvl  (100 units/ml)');


-- select distinct drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, ndc, prod_strength, route
-- from prescriptions
-- where formulary_drug_cd IN ('HEP1I', 'HEP10UI', 'HEPA10S', 'HEPA10SYR', 'HEPA10SYRN', 'HEPA100SYR',
--                                        'HEPAR10I', 'HEPF100I')

