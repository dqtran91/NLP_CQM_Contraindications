DROP TABLE IF EXISTS value_set.glycoprotein_iib_iiia_inhibitors;

CREATE TABLE IF NOT EXISTS value_set.glycoprotein_iib_iiia_inhibitors
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

COMMENT ON TABLE value_set.glycoprotein_iib_iiia_inhibitors IS '
Name: Glycoprotein IIb/IIIa Inhibitors
OID: 2.16.840.1.113762.1.4.1045.41
Code System: RXNORM
Definition Version: 20150430
Clinical Focus: This set of values contains codes which identify a select medication-a Glycoprotein Iib/IIIa inhibitor.
Data Element Scope: The intent of this data element is to identify patients who are on a Glycoprotein Iib/IIIa inhibitor.
    Using the Quality Data Model, this data element maps to the Medication category.
Inclusion Criteria: Only include codes which represent a Glycoprotein Iib/IIIa inhibitor. These are RxNorm codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1045.41/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
