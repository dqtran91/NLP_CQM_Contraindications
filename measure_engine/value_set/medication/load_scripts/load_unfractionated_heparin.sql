INSERT
INTO value_set.unfractionated_heparin (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions drug' AS source_system,
                      '2001-2012'          AS source_version,
                      drug                 AS source_code,
                      drug                 AS source_display
      FROM mimiciii.prescriptions
      WHERE (LOWER(drug) LIKE '%heparin%' OR
             LOWER(drug_name_poe) LIKE '%heparin%' OR
             LOWER(drug_name_generic) LIKE '%heparin%')
        AND UPPER(formulary_drug_cd) NOT IN ('AMID200', 'ATRO1I', 'COSO5ES', 'FURO40I',
                                             'HEP1I', 'HEP10UI', 'HEPA10S', 'HEPA10SYR', 'HEPA10SYRN', 'HEPA100SYR',
                                             'HEPAR10I', 'HEPF100I')
        AND UPPER(route) NOT IN ('DIALYS', 'DWELL', 'IP', 'IRR', 'LOCK', 'NG', 'PO', 'TP')
        AND LOWER(drug) NOT IN ('heparin flush', 'heparin flush (1000 units/ml)', 'heparin flush (5000 units/ml)',
                                'heparin flush crrt (5000 units/ml)', 'heparin flush cvl  (100 units/ml)')) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.unfractionated_heparin AS b WHERE b.source_code = a.source_code);
/*
 Worksheet:

 SELECT DISTINCT drug, drug_name_poe, drug_name_generic, formulary_drug_cd, gsn, medication, prod_strength, route
 FROM prescriptions
 WHERE formulary_drug_cd IN ('HEP1I', 'HEP10UI', 'HEPA10S', 'HEPA10SYR', 'HEPA10SYRN', 'HEPA100SYR',
                            'HEPAR10I', 'HEPF100I')
 */
