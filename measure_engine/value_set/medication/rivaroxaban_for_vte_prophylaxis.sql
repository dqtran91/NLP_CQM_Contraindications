DROP TABLE IF EXISTS value_set.rivaroxaban_for_vte_prophylaxis;

CREATE TABLE IF NOT EXISTS value_set.rivaroxaban_for_vte_prophylaxis
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

COMMENT ON TABLE value_set.rivaroxaban_for_vte_prophylaxis IS '
Name: Rivaroxaban and Betrixaban for VTE Prophylaxis
OID: 2.16.840.1.113762.1.4.1110.50
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This value set contains concepts that represent Rivaroxaban and Betrixaban indicated for venous thromboembolism (VTE) prophylaxis and treatment.
Data Element Scope: This value set may use the Quality Data Model (QDM) category related to Medication.
    The intent of this data element is to identify patients who receive Rivaroxaban and Betrixaban for VTE prophylaxis.
Inclusion Criteria: Includes only relevant concepts associated with oral forms of Rivaroxaban and Betrixaban.
Exclusion Criteria: NA
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.50/expansion/eCQM%20Update%202020-05-07
Note: From (NLM, 2023).';
