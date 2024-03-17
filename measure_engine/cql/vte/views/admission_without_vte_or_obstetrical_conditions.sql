CREATE OR REPLACE VIEW vte.admission_without_vte_or_obstetrical_conditions AS
SELECT *
FROM global.inpatient_encounter AS enc
WHERE NOT EXISTS (SELECT 1
                  FROM JSONB_ARRAY_ELEMENTS(enc.diagnoses) AS diag
                  WHERE diag ->> 'code' IN (SELECT code
                                            FROM cql.get_standard_icd9('obstetrical_or_pregnancy_related_conditions')
                                            UNION DISTINCT
                                            SELECT code
                                            FROM cql.get_standard_icd9('venous_thromboembolism')
                                            UNION DISTINCT
                                            SELECT code
                                            FROM cql.get_standard_icd9('obstetrics_vte')));

COMMENT ON VIEW vte.admission_without_vte_or_obstetrical_conditions IS '
VTE.Admission without VTE or Obstetrical Conditions
     Global."Inpatient Encounter" InpatientEncounter
      where not ( exists ( InpatientEncounter.diagnoses EncounterDiagnoses
            where ( EncounterDiagnoses.code in "Obstetrics"
                or EncounterDiagnoses.code in "Venous Thromboembolism"
                or EncounterDiagnoses.code in "Obstetrics VTE"
            )
        )
      )

Note: From CMS108v11 (eCQI, 2023).';
