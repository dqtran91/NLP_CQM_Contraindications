DROP TABLE IF EXISTS value_set.onc_administrative_sex;

CREATE TABLE IF NOT EXISTS value_set.onc_administrative_sex
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

COMMENT ON TABLE value_set.onc_administrative_sex IS '
Name: ONC Administrative Sex
OID: 2.16.840.1.113762.1.4.1
Code System: AdministrativeGender
Definition Version: 20150331
Clinical Focus: Gender identity restricted to only Male and Female used in administrative situations requiring a restriction to these two categories.
Data Element Scope: Gender
Inclusion Criteria: Male and Female only.
Exclusion Criteria: Any gender identity that is not male or female.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
