DROP TABLE IF EXISTS value_set.vte_risk_assessment;

CREATE TABLE IF NOT EXISTS value_set.vte_risk_assessment
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

COMMENT ON TABLE value_set.vte_risk_assessment IS '
Name: VTE Risk Assessment
OID: 2.16.840.1.113883.3.117.1.7.1.357
Code System: LOINC
Definition Version: 20170726
Clinical Focus: This set of values identify a tool used to assess the amount of risk that a patient has to develop a VTE.
Data Element Scope: The intent of this data element is to identify patients who have an assessment of their risk to develop a VTE.
    Using the Quality Data Model, this particular element will map to the Risk Category Assessment category with a result attribute.
Inclusion Criteria: Only use codes which represent a risk assessment tool used to assess a patient''s risk to develop a VTE. Codes used are to be LOINC only.
Exclusion Criteria: Exclude any codes which are not LOINC or which are LOINC, but which do not represent a risk assessment tool used to assess a patient''s risk to develop a VTE.
URL: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.357/expansion/eCQM%20Update%202018%20EP-EC%20and%20EH
Note: From (NLM, 2023).';
