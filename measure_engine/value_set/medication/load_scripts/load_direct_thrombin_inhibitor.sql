INSERT
INTO value_set.direct_thrombin_inhibitor (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE LOWER(drug) LIKE '%dabigatran%' OR
            LOWER(drug_name_poe) LIKE '%dabigatran%' OR
            LOWER(drug_name_generic) LIKE '%dabigatran%' OR
            LOWER(drug) LIKE '%etexilate%' OR
            LOWER(drug_name_poe) LIKE '%etexilate%' OR
            LOWER(drug_name_generic) LIKE '%etexilate%' OR
            LOWER(drug) LIKE '%argatroban%' OR
            LOWER(drug_name_poe) LIKE '%argatroban%' OR
            LOWER(drug_name_generic) LIKE '%argatroban%' OR
            LOWER(drug) LIKE '%bivalirudin%' OR
            LOWER(drug_name_poe) LIKE '%bivalirudin%' OR
            LOWER(drug_name_generic) LIKE '%bivalirudin%') AS A
WHERE NOT EXISTS (SELECT 1 FROM value_set.direct_thrombin_inhibitor AS b WHERE b.source_code = a.source_code);
