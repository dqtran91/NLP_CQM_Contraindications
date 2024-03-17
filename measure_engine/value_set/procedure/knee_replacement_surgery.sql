DROP TABLE IF EXISTS value_set.knee_replacement_surgery;

CREATE TABLE IF NOT EXISTS value_set.knee_replacement_surgery
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

COMMENT ON TABLE value_set.knee_replacement_surgery IS '
Name: Knee Replacement Surgery
OID: 2.16.840.1.113883.3.117.1.7.1.261
Code System: ICD10PCS, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have total knee replacement procedures.
Data Element Scope: The intent of this data element is to identify patients who have a total knee replacement procedure.
    Using the Quality Data Model, this particular element will map to the Procedure category.
Inclusion Criteria: Only use codes which represent the surgical procedure of a total knee replacement.
    This is a grouping of ICD9, ICD10 and SNOMED-CT codes and concepts.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.261/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*
 0070,
 0071,
 0072,
 0073,
 0080,
 0081,
 0082,
 0083,
 0084,
 7609,
 7840,
 7846,
 7860,
 7866,
 7900,
 7920,
 7970,
 7990,
 7999,
 8000,
 8001,
 8002,
 8003,
 8004,
 8005,
 8006,
 8007,
 8008,
 8009,
 8010,
 8016,
 8054,
 8154,
 8155,
 8196,
 8303,
 8394,
 8457,
 8459,
 8466,
 8467,
 8468
 */
