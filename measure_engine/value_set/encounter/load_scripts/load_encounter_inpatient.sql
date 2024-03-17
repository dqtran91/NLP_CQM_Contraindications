INSERT
INTO value_set.encounter_inpatient (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'current procedural terminology' AS source_system,
                      '2001-2012'                      AS source_version,
                      cpt_cd                           AS source_code,
                      subsectionheader                 AS source_display
      FROM mimiciii.cptevents
      WHERE LOWER(subsectionheader) IN
            ('hospital inpatient services', 'follow-up inpatient consultations (deleted codes)')) AS a
WHERE NOT EXISTS (SELECT 1 FROM value_set.encounter_inpatient AS b WHERE b.source_code = a.source_code);
