DROP TABLE IF EXISTS value_set.hemorrhagic_stroke;

CREATE TABLE IF NOT EXISTS value_set.hemorrhagic_stroke
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

COMMENT ON TABLE value_set.hemorrhagic_stroke IS '
Name: Hemorrhagic Stroke
OID: 2.16.840.1.113883.3.117.1.7.1.212
Code System: ICD10CM, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have had a hemorrhagic stroke, or stroke caused by hemorrhage.
Data Element Scope: The intent of this data element is to identify patients who have a diagnosis of hemorrhagic stroke, or stroke caused by a hemorrhage.
    Using the Quality Data Model, this particular element will map to the Diagnosis, category.
Inclusion Criteria: Only use codes which represent a diagnosis of hemorrhagic stroke, or stroke caused by hemorrhage. This is a grouping of ICD9CM, ICD10CM and SNOMED-CT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.212/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
/*
 430
 431
 */
