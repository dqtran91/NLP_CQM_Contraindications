DROP TABLE IF EXISTS value_set.venous_foot_pumps;

CREATE TABLE IF NOT EXISTS value_set.venous_foot_pumps
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

COMMENT ON TABLE value_set.venous_foot_pumps IS '
Name: Venous foot pumps (VFP)
OID: 2.16.840.1.113883.3.117.1.7.1.230
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values identifies patients who have a venous foot pump device applied for VTE prophylaxis.
Data Element Scope: The intent of this data element is to identify patients who have a venous foot pump device applied for VTE prophylaxis.
    Using the Quality Data Model, this particular element will map to the Device, Applied datatype.
Inclusion Criteria: Only use codes which represent venous foot pump devices which are used for VTE prophylaxis. Codes used are to be SNOMED-CT codes only.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.230/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
