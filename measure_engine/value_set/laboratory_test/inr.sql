DROP TABLE IF EXISTS value_set.inr;

CREATE TABLE IF NOT EXISTS value_set.inr
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

COMMENT ON TABLE value_set.inr IS '
Name: INR
OID: 2.16.840.1.113883.3.117.1.7.1.213
Code System: LOINC
Definition Version: 20150430
Clinical Focus: This set of values contains codes for laboratory test for INR, or International Normalized Ratio.
Data Element Scope: The intent of this data element is to identify INR laboratory tests.
    Using the Quality Data Model, this data element maps to the Laboratory Test category.
Inclusion Criteria: Only include codes which represent a laboratory test of INR (International Normalized Ratio). These are LOINC codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.213/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';

/*
 34714-6
 38875-1
 46418-0
 52129-4
 6301-6
 */
