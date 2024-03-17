INSERT
INTO value_set.onc_administrative_sex (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'patients gender' AS source_system,
                      '2001-2012'       AS source_version,
                      gender            AS source_code,
                      gender            AS source_display
      FROM mimiciii.patients) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.onc_administrative_sex AS b WHERE b.source_code = a.source_code);
