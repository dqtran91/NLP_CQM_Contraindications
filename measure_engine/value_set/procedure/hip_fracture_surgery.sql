DROP TABLE IF EXISTS value_set.hip_fracture_surgery;

CREATE TABLE IF NOT EXISTS value_set.hip_fracture_surgery
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

COMMENT ON TABLE value_set.hip_fracture_surgery IS '
Name: Hip Fracture Surgery
OID: 2.16.840.1.113883.3.117.1.7.1.258
Code System: ICD10PCS, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have procedures of hip fracture surgery.
Data Element Scope: The intent of this data element is to identify patients who have a hip fracture surgery procedure.
    Using the Quality Data Model, this particular element will map to the Procedure category.
Inclusion Criteria: Only use codes which represent hip fracture surgery. This is a grouping of ICD9CM Procedure, ICD10PCS and SNOMED-CT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.258/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*
 7970,
 7971,
 7972,
 7973,
 7974,
 7979,
 8140,
 8147,
 8149,
 8196
 */
