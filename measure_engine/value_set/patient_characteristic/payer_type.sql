DROP TABLE IF EXISTS value_set.payer_type;

CREATE TABLE IF NOT EXISTS value_set.payer_type
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

COMMENT ON TABLE value_set.payer_type IS '
Name: Payer
OID: 2.16.840.1.114222.4.11.3591
Code System: SOP
Definition Version: 20121025
Clinical Focus: Categories of types of health care payor entities as defined by the US Public Health Data Consortium SOP code system
Data Element Scope: @code in CCDA r2.1 template Planned Coverage [act: identifier urn:oid:2.16.840.1.113883.10.20.22.4.129 (open)] DYNAMIC
Inclusion Criteria: All codes in the code system
Exclusion Criteria: none
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.114222.4.11.3591/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023). 20121025 had no description so used descriptions from 20180718 instead for clinical focus, data element scope, inclusion criteria, and exclusion criteria.';
