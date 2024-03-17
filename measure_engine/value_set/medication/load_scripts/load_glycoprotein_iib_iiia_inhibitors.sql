INSERT
INTO value_set.glycoprotein_iib_iiia_inhibitors (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE LOWER(drug) LIKE '%eptifibatide%' OR
            LOWER(drug_name_poe) LIKE '%eptifibatide%' OR
            LOWER(drug_name_generic) LIKE '%eptifibatide%' OR
            LOWER(drug) LIKE '%tirofiban%' OR
            LOWER(drug_name_poe) LIKE '%tirofiban%' OR
            LOWER(drug_name_generic) LIKE '%tirofiban%' OR
            LOWER(drug) LIKE '%abciximab%' OR
            LOWER(drug_name_poe) LIKE '%abciximab%' OR
            LOWER(drug_name_generic) LIKE '%abciximab%') AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.glycoprotein_iib_iiia_inhibitors AS b WHERE b.source_code = a.source_code);
