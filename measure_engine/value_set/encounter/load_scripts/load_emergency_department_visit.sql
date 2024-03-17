INSERT
INTO value_set.emergency_department_visit (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'admission types'      AS source_system,
                      '2001-2012'            AS source_version,
                      admission_type         AS source_code,
                      'emergency department' AS source_display
      FROM mimiciii.admissions
      WHERE admission_type = 'EMERGENCY') AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.emergency_department_visit AS b WHERE b.source_code = a.source_code);
;
