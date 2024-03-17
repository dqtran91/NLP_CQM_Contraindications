INSERT
INTO value_set.low_dose_unfractionated_heparin_for_vte_prophylaxis (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE (LOWER(drug) LIKE '%heparin%' OR
             LOWER(drug_name_poe) LIKE '%heparin%' OR
             LOWER(drug_name_generic) LIKE '%heparin%')
        AND LOWER(drug) != 'heparin flush crrt (5000 units/ml)'
        AND UPPER(route) IN ('SC', 'SUBCUT')) AS a
WHERE NOT EXISTS (SELECT 1
                  FROM value_set.low_dose_unfractionated_heparin_for_vte_prophylaxis AS b
                  WHERE b.source_code = a.source_code);

/*
 -- Worksheet:
 SELECT DISTINCT drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, medication, prod_strength, route,
                 dose_val_rx, dose_unit_rx, form_val_disp, form_unit_disp
 FROM mimiciii.prescriptions
 WHERE LOWER(drug) LIKE '%heparin%'
   AND prod_strength = '25,000 unit Premix Bag';
 */
