DROP TABLE IF EXISTS value_set.low_dose_unfractionated_heparin_for_vte_prophylaxis;

CREATE TABLE IF NOT EXISTS value_set.low_dose_unfractionated_heparin_for_vte_prophylaxis
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

COMMENT ON TABLE value_set.low_dose_unfractionated_heparin_for_vte_prophylaxis IS '
Name: Low Dose Unfractionated Heparin for VTE Prophylaxis
OID: 2.16.840.1.113762.1.4.1045.39
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values contains unfractionated heparin medications with strengths that could reasonably be used for VTE prophylaxis.
Data Element Scope: The intent of this data element is to identify patients who are on low-dose unfractionated heparin as VTE prophylaxis.
    Using the Quality Data Model, this data element maps to the Medication category.
Inclusion Criteria: Only include RxNorm codes which specifically represent unfractionated heparins, both vials and pre-filled syringes.
Exclusion Criteria: Exclude concentrations less than 250 UNT/ML
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1045.39/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023). Heparin flush and heparin lock flush are excluded because they are used  to keep IV catheters open and flowing freely,
    and not for anti-coagulation';
