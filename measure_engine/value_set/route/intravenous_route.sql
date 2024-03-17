DROP TABLE IF EXISTS value_set.intravenous_route;

CREATE TABLE IF NOT EXISTS value_set.intravenous_route
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

COMMENT ON TABLE value_set.intravenous_route IS '
Name: Intravenous route
OID: 2.16.840.1.113883.3.117.1.7.1.222
Code System: SNOMEDCT
Definition Version: 20150430
Clinical Focus: This set of values identifies the route by which a medication is administered, in this case an intravenous route.
Data Element Scope: The intent of this data element is to identify the route by which a medication is administered, in this case an intravenous route.
    Using the Quality Data Model, this particular element is an attribute.
Inclusion Criteria: Only use codes which identify an intravenous route for giving a medication. Codes used are to be SNOMED-CT codes only.
Exclusion Criteria: Exclude codes that do not meet the inclusion criteria.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.222/expansion/MU2%20Update%202015-05-01
Note: From (NLM, 2023).';
