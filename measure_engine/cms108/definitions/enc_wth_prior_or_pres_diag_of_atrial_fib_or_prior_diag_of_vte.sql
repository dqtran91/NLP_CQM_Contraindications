CREATE OR REPLACE VIEW cms108.enc_wth_prior_or_pres_diag_of_atrial_fib_or_prior_diag_of_vte AS
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
JOIN (SELECT daf.hadm_id,
             (diag ->> 'prevalence_period')::TSRANGE AS prevalence_period
      FROM qdm.diagnosis_atrial_fibrillation_flutter AS daf,
           JSONB_ARRAY_ELEMENTS(daf.diagnoses)       AS diag)        AS af ON af.hadm_id = qe.hadm_id
WHERE LOWER(af.prevalence_period) <= UPPER(qe.relevant_period)
UNION DISTINCT
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(qe.diagnoses) AS qedg
              WHERE qedg ->> 'code' IN (SELECT code FROM cql.get_standard_icd9('atrial_fibrillation_or_flutter')))
UNION DISTINCT
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
JOIN (SELECT dvt.hadm_id,
             (diag ->> 'prevalence_period')::TSRANGE AS prevalence_period
      FROM qdm.diagnosis_venous_thromboembolism AS dvt,
           JSONB_ARRAY_ELEMENTS(dvt.diagnoses)  AS diag)             AS vta ON vta.hadm_id = qe.hadm_id
WHERE LOWER(vta.prevalence_period) < LOWER(qe.relevant_period);

COMMENT ON VIEW cms108.enc_wth_prior_or_pres_diag_of_atrial_fib_or_prior_diag_of_vte IS '
Encounter with Prior or Present Diagnosis of Atrial Fibrillation or Prior Diagnosis of VTE
    ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
        with ["Diagnosis": "Atrial Fibrillation/Flutter"] AtrialFibrillation
          such that AtrialFibrillation.prevalencePeriod starts on or before
          end of QualifyingEncounter.relevantPeriod
    )
      union ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
          where exists ( QualifyingEncounter.diagnoses QualifyingEncounterDiagnoses
              where QualifyingEncounterDiagnoses.code in "Atrial Fibrillation/Flutter"
          )
      )
      union ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
          with ["Diagnosis": "Venous Thromboembolism"] VTEDiagnosis
            such that VTEDiagnosis.prevalencePeriod starts before start of QualifyingEncounter.relevantPeriod
      )

Note: From CMS108v11 (eCQI, 2023).'
