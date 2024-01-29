DROP TABLE IF EXISTS value_set.comfort_measures;
CREATE TABLE IF NOT EXISTS value_set.comfort_measures
(
    id               BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    source_system    TEXT,
    source_version   TEXT,
    source_code      TEXT,
    source_display   TEXT,
    standard_system  TEXT,
    standard_version TEXT,
    standard_code    TEXT,
    standard_display TEXT
);


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