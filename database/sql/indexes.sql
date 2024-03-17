/* --- chartevents table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_chartevents_hadmid;
DROP INDEX IF EXISTS idx_chartevents_itemid;
DROP INDEX IF EXISTS idx_chartevents_subjectid;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_chartevents_hadmid ON mimiciii.chartevents (hadm_id);
CREATE INDEX IF NOT EXISTS idx_chartevents_itemid ON mimiciii.chartevents (itemid);
CREATE INDEX IF NOT EXISTS idx_chartevents_subjectid ON mimiciii.chartevents (subject_id);

-- Analyze table
ANALYZE mimiciii.chartevents;

/* --- admissions table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_admissions_admittime;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_admissions_admittime ON mimiciii.admissions (admittime);

-- Analyze table
ANALYZE mimiciii.admissions;

/* --- diagnoses_icd table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_diagnosesicd_hadmid;
DROP INDEX IF EXISTS idx_diagnosesicd_subjectid;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_diagnosesicd_hadmid ON mimiciii.diagnoses_icd (hadm_id);
CREATE INDEX IF NOT EXISTS idx_diagnosesicd_subjectid ON mimiciii.diagnoses_icd (subject_id);

-- Analyze table
ANALYZE mimiciii.diagnoses_icd;

/* --- prescriptions table --- */
-- Drop indexes
DROP INDEX IF EXISTS idx_prescriptions_ndc;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_prescriptions_ndc ON mimiciii.prescriptions (ndc);

-- Analyze table
ANALYZE mimiciii.prescriptions;
