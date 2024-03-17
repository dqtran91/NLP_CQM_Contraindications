INSERT
INTO value_set.observation_services (source_system, source_version, source_code, source_display)
SELECT a.*
FROM (SELECT DISTINCT 'current procedural terminology' AS source_system,
                      '2001-2012'                      AS source_version,
                      cpt_cd                           AS source_code,
                      subsectionheader                 AS source_display
      FROM mimiciii.cptevents
      WHERE LOWER(subsectionheader) = 'hospital observation services'
      UNION DISTINCT
      SELECT DISTINCT 'http://hl7.org/fhir/sid/icd-9-cm' AS source_system,
                      '2001-2012'                        AS source_version,
                      icd9_code                          AS source_code,
                      long_title                         AS source_display
      FROM mimiciii.d_icd_diagnoses
      WHERE short_title ILIKE '%observation%' OR
            long_title ILIKE '%observation%') AS a
WHERE NOT EXISTS (SELECT 1
                  FROM value_set.observation_services AS b
                  WHERE b.source_system = a.source_system
                    AND b.source_code = a.source_code);
