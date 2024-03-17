-- TODO: add a comfort care option when running the ETL.

DROP TABLE IF EXISTS value_set.comfort_measures;

CREATE TABLE IF NOT EXISTS value_set.comfort_measures
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

COMMENT ON TABLE value_set.comfort_measures IS '
Name: Comfort Measures
OID: 1.3.6.1.4.1.33895.1.3.0.45
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values contains care regimes used to define comfort measure care.
Data Element Scope: The intent of this data element is to identify patients receiving comfort measures care.
    Using the Quality Data Model, this particular element would map to the Intervention category.
Inclusion Criteria: Include SNOMEDCT regime and therapy codes for comfort measures, terminal care, dying care, and hospice care.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria. Exclude procedures, observations and findings associated with the term comfort.
URL: https://vsac.nlm.nih.gov/valueset/1.3.6.1.4.1.33895.1.3.0.45/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023). In Mimic-III, palliative care is treated the same as comfort care.';
