INSERT
INTO value_set.low_risk (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'drg codes severity' AS source_system,
                      '2001-2012'          AS source_version,
                      drg_severity::TEXT   AS source_code,
                      drg_severity         AS source_display
      FROM mimiciii.drgcodes
      WHERE drg_severity IN (0, 1)) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.low_risk AS b WHERE b.source_code = a.source_code);
