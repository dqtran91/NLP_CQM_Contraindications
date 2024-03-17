DROP TABLE IF EXISTS value_set.intermittent_pneumatic_compression_devices;

CREATE TABLE IF NOT EXISTS value_set.intermittent_pneumatic_compression_devices
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

COMMENT ON TABLE value_set.intermittent_pneumatic_compression_devices IS '
Name: Intermittent pneumatic compression devices (IPC)
OID: 2.16.840.1.113883.3.117.1.7.1.214
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values represents the different types of intermittent pneumatic compression devices used for VTE prophylaxis.
Data Element Scope: The intent of this data element is to represent the application of certain intermittent pneumatic compression devices.
    Using the Quality Data Model, this data element will map to the Device, Applied datatype.
Inclusion Criteria: Only include codes which represent different types of intermittent pneumatic compression devices. Codes used are to be SNOMED-CT codes only.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.214/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
