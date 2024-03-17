DROP TABLE IF EXISTS value_set.low_risk;

CREATE TABLE IF NOT EXISTS value_set.low_risk
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

COMMENT ON TABLE value_set.low_risk IS '
Name: Low Risk
OID: 2.16.840.1.113883.3.117.1.7.1.400
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values represents the result of an assessment or other measurement or observation that is "low".
    The concepts are represented using SNOMED-CT codes.
Data Element Scope: The intent of this data element is to identify patients who have an observation or measurement of an assessment which is "low".
    Using the Quality Data Model, this data element maps to an attribute.
Inclusion Criteria: Only include SNOMED-CT codes which specifically represent a qualifier value of "low".
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.400/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
