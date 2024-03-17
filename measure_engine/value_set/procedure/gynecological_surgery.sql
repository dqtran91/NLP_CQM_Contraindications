DROP TABLE IF EXISTS value_set.gynecological_surgery;

CREATE TABLE IF NOT EXISTS value_set.gynecological_surgery
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

COMMENT ON TABLE value_set.gynecological_surgery IS '
Name: Gynecological Surgery
OID: 2.16.840.1.113883.3.117.1.7.1.257
Code System: ICD10PCS, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping of value sets identifies patients who have procedures of gynecologic surgery.
Data Element Scope: The intent of this data element is to identify patients who have a gynecologic surgery procedure.
    Using the Quality Data Model, this particular element will map to the Procedure category.
Inclusion Criteria: Only use codes which represent gynecologic surgery procedures. This is a grouping of ICD9CM Procedures, ICD10PCS and SNOMED-CT codes and concepts.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.257/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*
 SELECT * FROM value_set.gynecological_surgery;
 4576,
 4840,
 4843,
 4849,
 4850,
 4852,
 4861,
 4862,
 4863,
 4864,
 4865,
 4869,
 5771,
 5779,
 5839,
 6522,
 6529,
 6539,
 6541,
 6549,
 6551,
 6552,
 6561,
 6562,
 6563,
 6564,
 6602,
 6621,
 6622,
 6629,
 6631,
 6632,
 6639,
 664,
 6651,
 6652,
 6661,
 6662,
 6663,
 6669,
 6692,
 6697,
 674,
 6831,
 6839,
 6841,
 6849,
 6851,
 6859,
 6861,
 6869,
 6871,
 6879,
 688,
 689,
 6919,
 6929,
 6998,
 704,
 743
 */
