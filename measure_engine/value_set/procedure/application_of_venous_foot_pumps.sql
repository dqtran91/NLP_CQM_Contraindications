DROP TABLE IF EXISTS value_set.application_of_venous_foot_pumps;

CREATE TABLE IF NOT EXISTS value_set.application_of_venous_foot_pumps
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

--TODO: check for data
COMMENT ON TABLE value_set.application_of_venous_foot_pumps IS '
Name: Application of Venous Foot Pumps (VFP)
OID: 2.16.840.1.113762.1.4.1110.64
Code System: SNOMEDCT
Definition Version: 20220212
Clinical Focus: The purpose of this value set is to identify concepts of the procedure for the application of venous foot pump for venous thromboembolism (VTE) prophylaxis.
Data Element Scope: This value set may use a model element related to procedure.
Inclusion Criteria: Includes concepts that represent the procedure of the application of a device used for venous thromboembolism (VTE) prophylaxis.
Exclusion Criteria: No exclusions.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1110.64/expansion/eCQM%20Update%202022-05-05
Note: From (NLM, 2023).';
