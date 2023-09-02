/* --- chartevents table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_chartevents_itemid;
DROP INDEX IF EXISTS idx_chartevents_subjectid;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_chartevents_itemid ON chartevents (itemid);
CREATE INDEX IF NOT EXISTS idx_chartevents_subjectid ON chartevents (subject_id);

-- Analyze table
ANALYZE chartevents;

/* --- admissions table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_admissions_admittime;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_admissions_admittime ON admissions (admittime);

-- Analyze table
ANALYZE admissions;

/* --- diagnoses_icd table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_diagnosesicd_hadmid;
DROP INDEX IF EXISTS idx_diagnosesicd_subjectid;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_diagnosesicd_hadmid ON diagnoses_icd (hadm_id);
CREATE INDEX IF NOT EXISTS idx_diagnosesicd_subjectid ON diagnoses_icd (subject_id);

-- Analyze table
ANALYZE diagnoses_icd;

/* --- prescriptions table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_prescriptions_ndc;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_prescriptions_ndc ON prescriptions (ndc);

-- Analyze table
ANALYZE prescriptions;