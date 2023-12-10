/*
 Recreate materialized view for comfort measures procedure codes.
 value set oid: 1.3.6.1.4.1.33895.1.3.0.45
 url: https://vsac.nlm.nih.gov/valueset/1.3.6.1.4.1.33895.1.3.0.45/expansion/
 Code system: SNOMEDCT
 Definition version: 20210611
 Inclusion: Includes concepts that identify an intervention for comfort measures, terminal care, dying care and hospice care.
 Exclusion: Excludes concepts that identify palliative care.
 note:
 The available open-source snomed-to-icd did not gave results for the snomed code in this value set, so searching
 was performed for the following terms in the procedure- and diagnosis-icd tables: comfort, dying, hospice, and terminal.
 There was no results.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.comfort_measures;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.comfort_measures AS
SELECT DISTINCT diag.*
FROM mimiciii.diagnoses_icd AS diag
JOIN d_icd_diagnoses AS icd on icd.icd9_code = diag.icd9_code
WHERE icd.short_title ILIKE '%comfort care%'
or icd.short_title ILIKE '%dying care%'
or icd.short_title ILIKE '%hospice care%'
or icd.short_title ILIKE '%terminal care%';


-- comfort care example
select subject_id, hadm_id
from noteevents
where row_id = 44381;

select * from patients where subject_id = 50227;

select * from admissions where hadm_id = 183663;

select * from icustays where hadm_id = 183663;

select *
from diagnoses_icd di
join d_icd_diagnoses d on di.icd9_code = d.icd9_code
where subject_id = 50227;

select *
from cptevents c
join d_cpt d on c.cpt_cd::INTEGER between d.mincodeinsubsection and d.maxcodeinsubsection
where subject_id = 50227;

SELECT * from drgcodes
where subject_id = 50227;

select *
from services
where subject_id = 50227;

select *
from transfers
where subject_id = 50227;

select DISTINCT d.*
from chartevents ce
join d_items d on ce.itemid = d.itemid
where subject_id = 50227