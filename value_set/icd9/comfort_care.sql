/*
 Recreate materialized view for comfort measures icd9 codes.
 value set oid: 1.3.6.1.4.1.33895.1.3.0.45
 url: https://vsac.nlm.nih.gov/valueset/1.3.6.1.4.1.33895.1.3.0.45/expansion/
 Inclusion: Includes concepts that identify an intervention for comfort measures, terminal care, dying care and hospice care.
 Exclusion: Excludes concepts that identify palliative care.
 note: The 2022 value set exclude palliative care, while the 2012 value set includes palliative care.
 The decision was made to use the 2022 value set to avoid confusion.
 The available open-source snomed-to-icd did not gave results for the snomed code in this value set.
 This was done by searching for the following terms in the procedure- and diagnosis-icd tables: comfort, dying, hospice, and terminal.
 There was no results.
 */
-- DROP MATERIALIZED VIEW IF EXISTS value_set.comfort_measures;
-- CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.comfort_measures AS
-- SELECT DISTINCT icd9_code AS icd9_code
-- FROM mimiciii.d_icd_procedures
-- WHERE icd9_code IN ();
