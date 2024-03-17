INSERT
INTO value_set.intensive_care_unit (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'transfer care units' AS source_system,
                      '2001-2012'           AS source_version,
                      curr_careunit         AS source_code,
                      curr_careunit         AS source_display
      FROM mimiciii.transfers
      WHERE UPPER(curr_careunit) NOT IN ('NICU', 'NWARD')) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.intensive_care_unit AS b WHERE b.source_code = a.source_code);
