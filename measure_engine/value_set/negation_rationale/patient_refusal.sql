DROP TABLE IF EXISTS value_set.patient_refusal;

CREATE TABLE IF NOT EXISTS value_set.patient_refusal
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

COMMENT ON TABLE value_set.patient_refusal IS '
Name: Patient Refusal
OID: 2.16.840.1.113883.3.117.1.7.1.93
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values contains situations representing a patient''s refusal for treatment.
Data Element Scope: The intent of this data element is to identify reasons a patient refuses treatment.
    Using the Quality Data Model, this particular element will map to the " reason" attribute.
Inclusion Criteria: Only SNOMED CT codes representing a patient refusal should be included.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.93/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
