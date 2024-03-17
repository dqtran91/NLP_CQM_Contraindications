DROP TABLE IF EXISTS value_set.subcutaneous_route;

CREATE TABLE IF NOT EXISTS value_set.subcutaneous_route
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

COMMENT ON TABLE value_set.subcutaneous_route IS '
Name: Subcutaneous route
OID: 2.16.840.1.113883.3.117.1.7.1.223
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values identifies the route by which a medication is administered, in this case a subcutaneous route.
Data Element Scope: The intent of this data element is to identify the route by which a medication is administered, in this case a subcutaneous route.
    Using the Quality Data Model, this particular element is an attribute.
Inclusion Criteria: Only use codes which identify a subcutaneous route for giving a medication. These are SNOMED-CT codes.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.223/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
