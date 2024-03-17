DROP TABLE IF EXISTS value_set.unfractionated_heparin;

CREATE TABLE IF NOT EXISTS value_set.unfractionated_heparin
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

COMMENT ON TABLE value_set.unfractionated_heparin IS '
Name: Unfractionated Heparin
OID: 2.16.840.1.113883.3.117.1.7.1.218
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values identifies patients who receive Unfractionated Heparin as an intravenous infusion.
Data Element Scope: The intent of this data element is to identify patients who receive unfractionated heparin as an intravenous infusion.
    Using the Quality Data Model, this particular element will map to the Medication category.
Inclusion Criteria: Include RxNorm codes for unfractionated heparin as an injectable solution.
    Include heparin injectable solutions with concentrations 40 UNT/ML, 50 UNT/ML and 100 UNT/ML, as these represent premixed heparin infusion bags.
Exclusion Criteria: Exclude heparin concentrations < 250 UNT/ML (except those representing premixed heparin infusion bags, per inclusion criteria).
    Exclude pre-filled syringe dose forms.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.218/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023). For abbreviations, PB means IV piggyback, IP means intraperitoneal, NG means nasogastric.
    PO means oral, and TP means topical or transplacental (FDA, 2017; Madison Memorial Hospital, 2019).';
