/*
 * NOTEEVENTS
 If a patient is an outpatient, there will not be an HADM_ID associated with the note. If the patient is an inpatient,
 but was not admitted to the ICU for that particular hospital admission, then there will not be an HADM_ID associated with the note.

 A ‘1’ in the ISERROR column indicates that a physician has identified this note as an error.

 CATEGORY and DESCRIPTION define the type of note recorded. For example, a CATEGORY of ‘Discharge summary’ indicates
 that the note is a discharge summary, and the DESCRIPTION of ‘Report’ indicates a full report while a DESCRIPTION
 of ‘Addendum’ indicates an addendum (additional text to be added to the previous report).

 * ADMISSIONS
 The ADMISSIONS table defines all HADM_ID present in the sql_alchemy_utility, covering an admission period between 1 June 2001
 and 10 October 2012.

 * CALLOUT
 Provides information when a patient was READY for discharge from the ICU, and when the patient was actually discharged from the ICU.

 */


SELECT ne.row_id,
       ne.subject_id,
       ne.hadm_id,
       ne.chartdate as note_date,
       ne.category as note_category,
       ne.description as note_description,
       ne.iserror as note_iserror,
       ad.admittime as admission_date,
       ad.dischtime as discharge_date,
       ad.admission_type,
       ad.admission_location,
       ad.diagnosis as admission_diagnosis,
       ic.intime as icu_intime,
       ic.outtime as icu_outtime,
       ic.los as icu_lengthofstay
FROM noteevents ne
         JOIN patients p ON ne.subject_id = p.subject_id
         JOIN admissions ad ON ne.hadm_id = ad.hadm_id
         LEFT JOIN icustays ic ON ne.hadm_id = ic.hadm_id AND ne.subject_id = ic.subject_id
WHERE ne.row_id = 5909;


SELECT *
FROM noteevents
-- where hadm_id is NULL
WHERE row_id IN (
                 1846,
                 2741,
                 3675,
                 4558,
                 7224,
                 5909,
                 192,
                 5410,
                 44381
    );