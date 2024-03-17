CREATE OR REPLACE VIEW cms108.enc_wth_vte_ppx_rcvd_frm_hosp_start_to_day_after_adm_or_proc AS
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds           AS qe
JOIN (SELECT ppx.hadm_id,
             (p ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (p ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM cms108.pharmacological_or_mechanical_vte_prophylaxis_received AS ppx,
           JSONB_ARRAY_ELEMENTS(ppx.prophylaxes)                         AS p) AS vppx ON vppx.hadm_id = qe.hadm_id
WHERE LOWER(global.normalize_interval(vppx.relevant_datetime, vppx.relevant_period)) <@
      vte.from_hosp_start_day_to_day_after_admission(ROW (qe.hadm_id, qe.relevant_period))
UNION DISTINCT
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds           AS qe
JOIN (SELECT ppa.hadm_id,
             (p ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (p ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM qdm.procedure_performed_general_or_neuraxial_anesthesia AS ppa,
           JSONB_ARRAY_ELEMENTS(ppa.procedures)                    AS p)       AS ap ON ap.hadm_id = qe.hadm_id
JOIN (SELECT ppx.hadm_id,
             (p ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (p ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM cms108.pharmacological_or_mechanical_vte_prophylaxis_received AS ppx,
           JSONB_ARRAY_ELEMENTS(ppx.prophylaxes)                         AS p) AS vppx ON vppx.hadm_id = qe.hadm_id
WHERE UPPER(global.normalize_interval(ap.relevant_datetime, ap.relevant_period)) >=
      INTERVAL '1 day' + LOWER(ap.relevant_period)
  AND LOWER(global.normalize_interval(vppx.relevant_datetime, vppx.relevant_period)) <@
      tjc.day_of_or_day_after(UPPER(global.normalize_interval(ap.relevant_datetime, ap.relevant_period)));

COMMENT ON VIEW cms108.enc_wth_vte_ppx_rcvd_frm_hosp_start_to_day_after_adm_or_proc IS '
Encounter with VTE Prophylaxis Received From Day of Start of Hospitalization To Day After Admission or Procedure
    ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
        with "Pharmacological or Mechanical VTE Prophylaxis Received" VTEProphylaxis
          such that Global."NormalizeInterval" ( VTEProphylaxis.relevantDatetime, VTEProphylaxis.relevantPeriod ) starts during day of VTE."FromDayOfStartOfHospitalizationToDayAfterAdmission" ( QualifyingEncounter )
    )
      union ( from
          VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
          ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
          "Pharmacological or Mechanical VTE Prophylaxis Received" VTEProphylaxis
          where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) ends 1 day after day of start of QualifyingEncounter.relevantPeriod
            and Global."NormalizeInterval" ( VTEProphylaxis.relevantDatetime, VTEProphylaxis.relevantPeriod ) starts during day of TJC."CalendarDayOfOrDayAfter" (
            end of Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
          return QualifyingEncounter
      )

Note: From CMS108v11 (eCQI, 2023).';
