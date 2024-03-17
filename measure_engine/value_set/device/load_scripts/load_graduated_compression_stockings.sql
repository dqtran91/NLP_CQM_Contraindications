INSERT
INTO value_set.graduated_compression_stockings (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'chart event items' AS source_system,
                      '2001-2012'         AS source_version,
                      itemid::TEXT        AS source_code,
                      label               AS source_display
      FROM mimiciii.d_items AS d
      WHERE label ILIKE '%compression%' OR
            label ILIKE '%stocking%' OR
            label ILIKE '%hosiery%' OR
            label ILIKE '%anti embolic device%') AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.graduated_compression_stockings AS b WHERE b.source_code = a.source_code);
