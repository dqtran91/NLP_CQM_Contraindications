DROP TABLE IF EXISTS value_set.observation_services;

CREATE TABLE IF NOT EXISTS value_set.observation_services
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

COMMENT ON TABLE value_set.observation_services IS '
Name: Observation Services
OID: 2.16.840.1.113762.1.4.1111.143
Code System: SNOMEDCT
Definition Version: 20180321
Clinical Focus: This set of values identify the observation encounter types.
Data Element Scope: The intent of this data element is to identify patients who have had an observation encounter.
    Using the Quality Data Model, this particular element will map to the "encounter" category.
Inclusion Criteria: Only SNOMED CT codes representing inpatient encounter should be included.
Exclusion Criteria: None.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1111.143/expansion/eCQM%20Update%202018-09-17
Note: From (NLM, 2023).';
