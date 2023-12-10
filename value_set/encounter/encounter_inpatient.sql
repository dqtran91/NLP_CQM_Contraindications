/*
 Clinical Focus: The purpose of this value set is to represent concepts of inpatient hospitalization encounters.
 Value Set OID: 2.16.840.1.113883.3.666.5.307
 Url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.666.5.307/expansion/eCQM%20Update%202022-05-05
 Code System: SNOMEDCT
 Definition Version: 20210611
 Data Element Scope: This value set may use a model element related to Encounter.
 Inclusion: Includes concepts that represent an encounter for inpatient hospitalizations.
 Exclusion: None
 Note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so the admissions table was used instead. Additionally, there is no need for this view because it is the same as the admissions table.
 */
-- DROP MATERIALIZED VIEW IF EXISTS value_set.encounter_inpatient;
-- CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.encounter_inpatient AS
SELECT a.subject_id,
       a.hadm_id,
       a.admittime,
       a.dischtime,
       DATE_PART('day', a.dischtime - a.admittime) AS relevant_period,
       a.admission_type,
       a.admission_location,
       a.edregtime,
       a.edouttime,
       a.diagnosis,
       d.icd9_code
FROM mimiciii.admissions    AS a
JOIN mimiciii.diagnoses_icd AS d ON d.hadm_id = a.hadm_id AND d.subject_id = a.subject_id
WHERE UPPER(admission_type) != 'NEWBORN';