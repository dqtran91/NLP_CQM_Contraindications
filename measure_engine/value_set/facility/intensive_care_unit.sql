DROP TABLE IF EXISTS value_set.intensive_care_unit;

CREATE TABLE IF NOT EXISTS value_set.intensive_care_unit
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

COMMENT ON TABLE value_set.intensive_care_unit IS '
Name: Intensive Care Unit
OID: 2.16.840.1.113762.1.4.1029.206
Definition Version: 20190305
Code System: HSLOC, SNOMEDCT
Clinical Focus: This value set contains concepts that represent adult and pediatric intensive care units (ICU).
Data Element Scope: This value set may use Quality Data Model (QDM) datatype related to Encounter, Performed, or attribute related to Location.
    The intent of this data element is to identify patients in intensive care units.
Inclusion Criteria: Includes only relevant concepts associated adult and pediatric intensive care units (ICU).
    This is a grouping of HSLOC and SNOMEDCT codes.
Exclusion Criteria: Excludes concepts that pertain to neonatal intensive care units (NICU).
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1029.206/expansion/eCQM%20Update%202019-05-10
Note: From (NLM, 2023).';
