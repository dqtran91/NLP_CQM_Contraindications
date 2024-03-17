DROP TABLE IF EXISTS value_set.graduated_compression_stockings;

CREATE TABLE IF NOT EXISTS value_set.graduated_compression_stockings
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

COMMENT ON TABLE value_set.graduated_compression_stockings IS '
Name: Graduated compression stockings (GCS)
OID: 2.16.840.1.113883.3.117.1.7.1.256
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values contains codes and concepts for graduated compression stocking devices which are used to prevent VTEs in patients.
Data Element Scope: The intent of this data element is to identify patients who have a graduated compression stocking device applied.
    It may also be used to identify patients who did not have a graduated compression stocking device applied for VTE prophylaxis for an allowable reason when used with a negation rationale attribute.
    Using the Quality Data Model, this data element maps to the Device, Applied datatype.
Inclusion Criteria: Only include codes which represent graduated compression stockings. Codes used are to be SNOMED-CT codes only.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.256/expansion/eCQM%20Update%202022-05-05
Note: From (NLM, 2023).';
