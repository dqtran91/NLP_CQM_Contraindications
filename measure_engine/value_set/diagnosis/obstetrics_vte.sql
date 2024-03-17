DROP TABLE IF EXISTS value_set.obstetrics_vte;

CREATE TABLE IF NOT EXISTS value_set.obstetrics_vte
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

COMMENT ON TABLE value_set.obstetrics_vte IS '
Name: Obstetrics VTE
OID: 2.16.840.1.113883.3.117.1.7.1.264
Code System: ICD10CM, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have a venous thromboembolism related to pregnancy or obstetrics.
Data Element Scope: The intent of this data element is to identify patients who have a venous thromboembolism related to pregnancy or obstetrics.
    Using the Quality Data Model, this particular element will map to either the Diagnosis category.
Inclusion Criteria: Only use codes which represent a venous thromboembolism related to pregnancy or obstetrics.
    This is a grouping of ICD9, ICD10 and SNOMED-CT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.264/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
/*
 63460,
 63461,
 63462,
 63560,
 63561,
 63562,
 63660,
 63661,
 63662,
 63760,
 63761,
 63762,
 6386,
 6396,
 67130,
 67131,
 67133,
 67140,
 67142,
 67144,
 67150,
 67151,
 67152,
 67153,
 67154,
 67190,
 67191,
 67192,
 67193,
 67194,
 67320,
 67321,
 67322,
 67323,
 67324
 */
