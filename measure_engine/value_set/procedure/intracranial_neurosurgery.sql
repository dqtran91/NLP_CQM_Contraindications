DROP TABLE IF EXISTS value_set.intracranial_neurosurgery;

CREATE TABLE IF NOT EXISTS value_set.intracranial_neurosurgery
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

COMMENT ON TABLE value_set.intracranial_neurosurgery IS '
Name: Intracranial Neurosurgery
OID: 2.16.840.1.113883.3.117.1.7.1.260
Code System: ICD10PCS, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have procedures of intracranial neurosurgery.
Data Element Scope: The intent of this data element is to identify patients who have an intracranial neurosurgery procedure.
    Using the Quality Data Model, this particular element will map to the Procedure category.
Inclusion Criteria: Only use codes which represent intracranial neurosurgery.
    This is a grouping of ICD9CM Procedure, ICD10PCS and SNOMED-CT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.260/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*
 0101,
 0109,
 0111,
 0112,
 0113,
 0114,
 0115,
 0118,
 0121,
 0122,
 0123,
 0124,
 0125,
 0128,
 0131,
 0132,
 0139,
 0141,
 0142,
 0151,
 0152,
 0153,
 0159,
 016,
 0201,
 0206,
 0207,
 0214,
 0221,
 0222,
 0231,
 0232,
 0233,
 0234,
 0235,
 0239,
 0242,
 0243,
 0293,
 0294,
 0295,
 0301,
 1651,
 2095,
 240,
 2412,
 244,
 247,
 2732,
 7601,
 7609,
 7611,
 762,
 7639,
 7645,
 8000,
 8010,
 8030,
 8080,
 8090,
 9359,
 9395,
 9736,
 9923
 */
