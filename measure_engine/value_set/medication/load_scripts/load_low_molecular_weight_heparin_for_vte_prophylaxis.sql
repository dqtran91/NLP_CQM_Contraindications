INSERT
INTO value_set.low_molecular_weight_heparin_for_vte_prophylaxis (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE (LOWER(drug) LIKE '%enoxaparin%' OR
             LOWER(drug_name_poe) LIKE '%enoxaparin%' OR
             LOWER(drug_name_generic) LIKE '%enoxaparin%' OR
             LOWER(drug) LIKE '%lovenox%' OR
             LOWER(drug_name_poe) LIKE '%lovenox%' OR
             LOWER(drug_name_generic) LIKE '%lovenox%' OR
             LOWER(drug) LIKE '%dalteparin%' OR
             LOWER(drug_name_poe) LIKE '%dalteparin%' OR
             LOWER(drug_name_generic) LIKE '%dalteparin%' OR
             LOWER(drug) LIKE '%fragmin%' OR
             LOWER(drug_name_poe) LIKE '%fragmin%' OR
             LOWER(drug_name_generic) LIKE '%fragmin%')
        AND LOWER(drug) != 'dobutamine hcl') AS a
WHERE NOT EXISTS (SELECT 1
                  FROM value_set.low_molecular_weight_heparin_for_vte_prophylaxis AS b
                  WHERE b.source_code = a.source_code);
