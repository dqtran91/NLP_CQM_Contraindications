/*
 Clinical Focus: The purpose of this value set is to represent concepts of a procedure for surgery
 where a general and/or neuraxial anesthesia is used.
 value set oid: 2.16.840.1.113883.3.666.5.1743
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.666.5.1743/expansion/eCQM%20Update%202022-05-05
 Code System: ICD-9-PCS
 Inclusion: Includes concepts that represent a procedure for general and/or neuraxial anesthesia.
 Exclusion: No exclusions.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.general_neuraxial_anesthesia;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.general_neuraxial_anesthesia AS
SELECT DISTINCT icd9_code AS icd9_code
FROM mimiciii.d_icd_procedures
WHERE icd9_code IN ('3726', '4233', '668', '6695', '9912', '9913', '9923', '9927', '9929', '9975');