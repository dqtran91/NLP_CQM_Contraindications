/*
 Recreate materialized view for the assessment of the risk for venous thromboembolism.
 Code System: LOINC
 Code: 72136-5
 Term Type: LC
 Code System Version: 2.72
 url: https://vsac.nlm.nih.gov/context/cs/codesystem/LOINC/version/2.72/code/72136-5/info
 note: There was no results in mimic for this code.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.risk_for_venous_thromboembolism;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.risk_for_venous_thromboembolism AS
SELECT DISTINCT loinc_code
FROM mimiciii.d_labitems
where loinc_code = '72136-5';
