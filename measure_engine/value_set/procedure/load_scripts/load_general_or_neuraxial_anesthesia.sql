INSERT
INTO value_set.general_or_neuraxial_anesthesia (source_system, source_version, source_code, source_display)
SELECT *
FROM (SELECT DISTINCT 'http://hl7.org/fhir/sid/icd-9-cm' AS source_system,
                      '2001-2012'                        AS source_version,
                      icd9_code                          AS source_code,
                      long_title                         AS source_display
      FROM mimiciii.d_icd_procedures
      WHERE long_title ILIKE '%anesthetic%'
         OR LOWER(long_title) = 'eye examination under anesthesia') a
WHERE NOT EXISTS (SELECT 1 FROM value_set.general_or_neuraxial_anesthesia AS b WHERE b.source_code = a.source_code);

