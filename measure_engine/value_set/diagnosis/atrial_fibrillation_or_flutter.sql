DROP TABLE IF EXISTS value_set.atrial_fibrillation_or_flutter;

CREATE TABLE IF NOT EXISTS value_set.atrial_fibrillation_or_flutter
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

COMMENT ON TABLE value_set.atrial_fibrillation_or_flutter IS '
Name: Atrial Fibrillation/Flutter
OID: 2.16.840.1.113883.3.117.1.7.1.202
Code System: ICD10CM, ICD9CM, SNOMEDCT
Definition Version: 20150430
Clinical Focus: This grouping value set contains diagnoses used to identify patients with a history of atrial fibrillation/flutter or a current finding of atrial fibrillation/flutter.
Data Element Scope: The intent of this data element is to identify patients with a diagnosis of atrial fibrillation or flutter.
    Using the Quality Data Model, this particular element would map to the Diagnosis category.
Inclusion Criteria: Include codes that identify patients with a history of atrial fibrillation/flutter or a current finding of atrial fibrillation/flutter.
    This is a grouping of ICD10CM, ICD9CM and SNOMEDCT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.202/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
/*
 42731,
 42732
 */
