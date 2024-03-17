CREATE OR REPLACE VIEW cms108.enc_wth_principal_diagnosis_of_mental_disorder_or_stroke AS
SELECT *
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(qe.diagnoses) AS diag
              WHERE diag ->> 'rank' = '1' AND
                    diag ->> 'code' IN (SELECT code
                                        FROM cql.get_standard_icd9('mental_health_diagnoses')
                                        UNION DISTINCT
                                        SELECT code
                                        FROM cql.get_standard_icd9('hemorrhagic_stroke')
                                        UNION DISTINCT
                                        SELECT code
                                        FROM cql.get_standard_icd9('ischemic_stroke')));

COMMENT ON VIEW cms108.enc_wth_principal_diagnosis_of_mental_disorder_or_stroke IS '
Encounter with Principal Diagnosis of Mental Disorder or Stroke
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
      where exists ( QualifyingEncounter.diagnoses EncounterDiagnoses
          where EncounterDiagnoses.rank = 1
            and ( EncounterDiagnoses.code in "Mental Health Diagnoses"
                or EncounterDiagnoses.code in "Hemorrhagic Stroke"
                or EncounterDiagnoses.code in "Ischemic Stroke"
            )
      )

Note: From CMS108v11 (eCQI, 2023).'
