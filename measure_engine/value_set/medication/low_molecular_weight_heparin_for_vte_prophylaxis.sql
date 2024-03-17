DROP TABLE IF EXISTS value_set.low_molecular_weight_heparin_for_vte_prophylaxis;

CREATE TABLE IF NOT EXISTS value_set.low_molecular_weight_heparin_for_vte_prophylaxis
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

COMMENT ON TABLE value_set.low_molecular_weight_heparin_for_vte_prophylaxis IS '
Name: Low Molecular Weight Heparin for VTE Prophylaxis
OID: 2.16.840.1.113883.3.117.1.7.1.219
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values represents medications used for VTE prophylaxis. The medications are low molecular weight heparins.
The medications included in this value set are administered parenterally.
Data Element Scope: The intent of this data element is to identify patients who are on low molecular weight heparin therapy as VTE prophylaxis.
    Using the Quality Data Model, this data element maps to the Medication category.
Inclusion Criteria: Only include RxNorm codes which specifically represent low molecular weight heparins which are administered parenterally.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.219/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
