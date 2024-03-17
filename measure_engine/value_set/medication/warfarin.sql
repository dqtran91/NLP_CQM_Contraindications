DROP TABLE IF EXISTS value_set.warfarin;

CREATE TABLE IF NOT EXISTS value_set.warfarin
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

COMMENT ON TABLE value_set.warfarin IS '
Name: Warfarin
OID: 2.16.840.1.113883.3.117.1.7.1.232
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values contains Warfarin medications that are administered to patients to reduce the risk of blood clot formation.
Data Element Scope: The intent of this data element is to identify patients who are prescribed warfarin therapy at discharge following acute myocardial infarction.
    Using the Quality Data Model, this particular element would map to the Medication category.
Inclusion Criteria: Drug forms that are consistent with oral administration should be included: tablets. Only single ingredient.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.232/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
