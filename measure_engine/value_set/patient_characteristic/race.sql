DROP TABLE IF EXISTS value_set.race;

CREATE TABLE IF NOT EXISTS value_set.race
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

COMMENT ON TABLE value_set.race IS '
Name: Race
OID: 2.16.840.1.114222.4.11.836
Code System: CDCREC
Definition Version: 20121025
Clinical Focus: NA
Data Element Scope: NA
Inclusion Criteria: NA
Exclusion Criteria: NA
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.114222.4.11.836/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
