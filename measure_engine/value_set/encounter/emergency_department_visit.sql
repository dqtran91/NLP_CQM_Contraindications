DROP TABLE IF EXISTS value_set.emergency_department_visit;

CREATE TABLE IF NOT EXISTS value_set.emergency_department_visit
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

COMMENT ON TABLE value_set.emergency_department_visit IS '
Name: Emergency Department Visit
OID: 2.16.840.1.113883.3.117.1.7.1.292
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values identifies procedures representing an emergency department encounter.
Data Element Scope: The intent of this data element is to identify patients who have had an emergency department encounter.
    Using the Quality Data Model, this particular element will map to the "Encounter" category.
Inclusion Criteria: Include codes representing an emergency department visit encounter utilizing the SNOMED CT code system.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.292/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
