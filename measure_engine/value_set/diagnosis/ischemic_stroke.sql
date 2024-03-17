DROP TABLE IF EXISTS value_set.ischemic_stroke;

CREATE TABLE IF NOT EXISTS value_set.ischemic_stroke
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

COMMENT ON TABLE value_set.ischemic_stroke IS '
Name: Ischemic Stroke
OID: 2.16.840.1.113883.3.117.1.7.1.247
Code System: ICD10CM, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have had a stroke caused by ischemia,
    where the blood supply is restricted to an area of the brain by something like thrombosis or an embolism.
Data Element Scope: The intent of this data element is to identify patients who have a diagnosis of ischemic stroke, or stroke caused by ischemia.
    Using the Quality Data Model, this particular element will map to the Diagnosis category.
Inclusion Criteria: Only use codes which represent a diagnosis of ischemic stroke, or stroke caused by ischemia.
    This is a grouping of ICD9CM, ICD10CM and SNOMED-CT codes and concepts.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.247/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
/*
 SELECT * FROM value_set.ischemic_stroke;
 43301,
 43310,
 43311,
 43321,
 43331,
 43381,
 43391,
 43400,
 43401,
 43411,
 43491,
 436
 */
