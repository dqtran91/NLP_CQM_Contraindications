INSERT
INTO value_set.rivaroxaban_for_vte_prophylaxis (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE LOWER(drug) LIKE '%rivaroxaban%' OR
            LOWER(drug_name_poe) LIKE '%rivaroxaban%' OR
            LOWER(drug_name_generic) LIKE '%rivaroxaban%') AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.rivaroxaban_for_vte_prophylaxis AS b WHERE b.source_code = a.source_code);
