DROP TABLE IF EXISTS value_set.oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment;

CREATE TABLE IF NOT EXISTS value_set.oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment
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

COMMENT ON TABLE value_set.oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment IS '
Name: Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment
OID: 2.16.840.1.113883.3.117.1.7.1.134
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values identifies oral Factor Xa inhibitors indicated for VTE prophylaxis and treatment.
Data Element Scope: The intent of this data element is to identify patients who receive oral factor Xa inhibitors for VTE prophylaxis.
    Using the Quality Data Model, this particular element will map to the Medication category.
Inclusion Criteria: Oral forms of factor Xa inhibitors.
Exclusion Criteria: Other dose forms of factor Xa inhibitors.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.134/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
