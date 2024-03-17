INSERT
INTO value_set.intravenous_route (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'prescriptions route' AS source_system,
                      '2001-2012'           AS source_version,
                      route                 AS source_code,
                      route                 AS source_display
      FROM mimiciii.prescriptions
      WHERE UPPER(route) IN ('IV', 'IV BOLUS', 'IV DRIP', 'IVPCA', 'IVS', 'PB')) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.intravenous_route AS b WHERE b.source_code = a.source_code);
