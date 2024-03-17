DROP TABLE IF EXISTS value_set.general_or_neuraxial_anesthesia;

CREATE TABLE IF NOT EXISTS value_set.general_or_neuraxial_anesthesia
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

COMMENT ON TABLE value_set.general_or_neuraxial_anesthesia IS '
Name: General or Neuraxial Anesthesia
OID: 2.16.840.1.113883.3.666.5.1743
Code System: ICD10PCS, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This group of value sets identifies patients who have a surgical procedure where a general and/or neuraxial anesthesia is used.
Data Element Scope: The intent of this data element is to identify patients who have a surgical procedure where general and/or neuraxial anesthesia is used.
    Using the Quality Data Model, this particular element will map to the Procedure category.
Inclusion Criteria: Only use codes which represent general and/or neuraxial anesthesia. Codes used are to be ICD10PCS, ICD9 or SNOMED-CT codes only.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.666.5.1743/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*3726, 4233, 668, 6695, 9912, 9913, 9923, 9927, 9929, 9975*/


