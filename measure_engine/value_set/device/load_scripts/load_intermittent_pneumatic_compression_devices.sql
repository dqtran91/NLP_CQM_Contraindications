INSERT
INTO value_set.intermittent_pneumatic_compression_devices (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'chart event items' AS source_system,
                      '2001-2012'         AS source_version,
                      itemid:: TEXT       AS source_code,
                      label               AS source_display
      FROM mimiciii.d_items
      WHERE label ILIKE '%pneumo boots%') AS a
WHERE NOT EXISTS (SELECT 1
                  FROM value_set.intermittent_pneumatic_compression_devices AS b
                  WHERE b.source_code = a.source_code::TEXT);
