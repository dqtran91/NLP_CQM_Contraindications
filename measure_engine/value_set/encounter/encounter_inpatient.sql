DROP TABLE IF EXISTS value_set.encounter_inpatient;

CREATE TABLE IF NOT EXISTS value_set.encounter_inpatient
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

COMMENT ON TABLE value_set.encounter_inpatient IS '
Name: Encounter Inpatient
OID: 2.16.840.1.113883.3.666.5.307
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values identify the most common inpatient encounter types.
Data Element Scope: The intent of this data element is to identify patients who have had an inpatient encounter.
    Using the Quality Data Model, this particular element will map to the "encounter" category.
Inclusion Criteria: Only SNOMED CT codes representing inpatient encounter should be included.
Exclusion Criteria: Exclude codes that do not meet inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.666.5.307/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';



