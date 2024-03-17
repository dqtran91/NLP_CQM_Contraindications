DROP TABLE IF EXISTS value_set.injectable_factor_xa_inhibitor_for_vte_prophylaxis;

CREATE TABLE IF NOT EXISTS value_set.injectable_factor_xa_inhibitor_for_vte_prophylaxis
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

COMMENT ON TABLE value_set.injectable_factor_xa_inhibitor_for_vte_prophylaxis IS '
Name: Injectable Factor Xa Inhibitor for VTE Prophylaxis
OID: 2.16.840.1.113883.3.117.1.7.1.211
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values contains codes which identify a select medication-an injectable Factor Xa inhibitor-which is used for VTE prophylaxis.
Data Element Scope: The intent of this data element is to identify patients who are on a select Injectable Factor Xa Inhibitor as prophylaxis for VTE.
    Using the Quality Data Model, this data element maps to the Medication category.
Inclusion Criteria: Only include codes which represent injectable Factor Xa inhibitor medications. These are RxNorm codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.211/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
