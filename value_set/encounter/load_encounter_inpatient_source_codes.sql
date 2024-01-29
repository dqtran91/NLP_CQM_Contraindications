TRUNCATE TABLE value_set.observation_services;

INSERT
INTO value_set.encounter_inpatient (source_system, source_version, source_code, source_display)
SELECT DISTINCT 'current procedural terminology' AS source_system,
                '2001-2012'                      AS source_version,
                cpt_cd                           AS source_code,
                subsectionheader                 AS source_display
FROM mimiciii.cptevents
WHERE LOWER(subsectionheader) IN ('hospital inpatient services', 'follow-up inpatient consultations (deleted codes)');
