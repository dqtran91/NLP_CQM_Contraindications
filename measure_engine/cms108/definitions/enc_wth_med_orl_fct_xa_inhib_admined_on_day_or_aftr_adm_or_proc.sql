CREATE OR REPLACE VIEW cms108.enc_wth_med_orl_fct_xa_inhib_admined_on_day_or_aftr_adm_or_proc AS
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds                   AS qe
JOIN (SELECT *,
             (meds ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (meds ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM qdm.medication_administered_orl_fact_xa_inhib_for_vte_ppx_or_treat AS xa,
           JSONB_ARRAY_ELEMENTS(xa.medications)                               AS meds) AS xamed ON xamed.hadm_id = qe.hadm_id
WHERE LOWER(global.normalize_interval(xamed.relevant_datetime, xamed.relevant_period)) <@
      tjc.day_of_or_day_after(LOWER(qe.relevant_period))
UNION
DISTINCT
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds                  AS qe
JOIN (SELECT ppa.hadm_id,
             (p ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (p ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM qdm.procedure_performed_general_or_neuraxial_anesthesia AS ppa,
           JSONB_ARRAY_ELEMENTS(ppa.procedures)                    AS p)              AS ap ON ap.hadm_id = qe.hadm_id
JOIN (SELECT xvte.hadm_id,
             (med ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (med ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM qdm.medication_administered_orl_fact_xa_inhib_for_vte_ppx_or_treat AS xvte,
           JSONB_ARRAY_ELEMENTS(xvte.medications)                             AS med) AS xmed ON xmed.hadm_id = qe.hadm_id
WHERE UPPER(global.normalize_interval(ap.relevant_datetime, ap.relevant_period)) >=
      INTERVAL '1 day' + LOWER(ap.relevant_period)
  AND LOWER(global.normalize_interval(xmed.relevant_datetime, xmed.relevant_period)) <@
      tjc.day_of_or_day_after(UPPER(global.normalize_interval(ap.relevant_datetime, ap.relevant_period)));;



COMMENT ON VIEW cms108.enc_wth_med_orl_fct_xa_inhib_admined_on_day_or_aftr_adm_or_proc IS '
Encounter with Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure
    ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
        with ["Medication, Administered": "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
          such that Global."NormalizeInterval" ( FactorXaMedication.relevantDatetime, FactorXaMedication.relevantPeriod ) starts during day of TJC."CalendarDayOfOrDayAfter" ( start of QualifyingEncounter.relevantPeriod )
    )
      union ( from
          VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
          ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
          ["Medication, Administered": "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
          where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) ends 1 day after day of start of QualifyingEncounter.relevantPeriod
            and Global."NormalizeInterval" ( FactorXaMedication.relevantDatetime, FactorXaMedication.relevantPeriod ) starts during day of TJC."CalendarDayOfOrDayAfter" (
            end of Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
          return QualifyingEncounter
      )

Note: From CMS108v11 (eCQI, 2023).'
