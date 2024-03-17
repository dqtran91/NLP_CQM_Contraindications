INSERT
INTO value_set.oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE LOWER(drug) LIKE '%apixaban%' OR
            LOWER(drug_name_poe) LIKE '%apixaban%' OR
            LOWER(drug_name_generic) LIKE '%apixaban%' OR
            LOWER(drug) LIKE '%edoxaban%' OR
            LOWER(drug_name_poe) LIKE '%edoxaban%' OR
            LOWER(drug_name_generic) LIKE '%edoxaban%') AS a
WHERE NOT EXISTS (SELECT 1
                  FROM value_set.oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment AS b
                  WHERE b.source_code = a.source_code);
