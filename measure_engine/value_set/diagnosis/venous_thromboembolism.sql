DROP TABLE IF EXISTS value_set.venous_thromboembolism;

CREATE TABLE IF NOT EXISTS value_set.venous_thromboembolism
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

COMMENT ON TABLE value_set.venous_thromboembolism IS '
Name: Venous Thromboembolism
OID: 2.16.840.1.113883.3.117.1.7.1.279
Code System: ICD10CM, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have a venous thromboembolism, including those who have a pulmonary embolism.
Data Element Scope: The intent of this data element is to identify patients who have a venous thromboembolism, including those who have a pulmonary embolism.
    Using the Quality Data Model, this particular element will map to the Diagnosis category.
Inclusion Criteria: Only use codes representing pulmonary embolism and proximal venous thromboembolisms, including specific proximal veins:
    popliteal vein, femoral/superficial femoral vein, deep femoral vein, iliofemoral vein, iliac vein and inferior vena cava.
    This is a grouping of ICD9CM, ICD10CM and SNOMED-CT codes and concepts.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.279/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
/*
 41511,
 41513,
 41519,
 45111,
 45119,
 4512,
 45181,
 4519,
 4532,
 45340,
 45341,
 45387,
 45389,
 4539
 */
