CREATE OR REPLACE VIEW cms108.enc_wth_intv_comfort_meas_on_day_or_after_proc AS
SELECT qe.*
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
JOIN (SELECT icm.hadm_id,
             (intv ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (intv ->> 'relevant_period')::TSRANGE     AS relevant_period,
             (intv ->> 'author_datetime')::TIMESTAMP   AS author_datetime
      FROM cms108.intervention_comfort_measures    AS icm,
           JSONB_ARRAY_ELEMENTS(icm.interventions) AS intv)             AS cm ON cm.hadm_id = qe.hadm_id
JOIN (SELECT pp.hadm_id,
             (proc ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (proc ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM qdm.procedure_performed_general_or_neuraxial_anesthesia AS pp,
           JSONB_ARRAY_ELEMENTS(pp.procedures) AS proc)                 AS ppga ON ppga.hadm_id = qe.hadm_id
WHERE UPPER(global.normalize_interval(ppga.relevant_datetime, ppga.relevant_period)) >=
      INTERVAL '1 DAY' + LOWER(qe.relevant_period)
  AND COALESCE(LOWER(global.normalize_interval(cm.relevant_datetime, cm.relevant_period)), cm.author_datetime) <@
      tjc.day_of_or_day_after(UPPER(global.normalize_interval(ppga.relevant_datetime, ppga.relevant_period)));

COMMENT ON VIEW cms108.enc_wth_intv_comfort_meas_on_day_or_after_proc IS '
Encounter with Intervention Comfort Measures on Day of or Day After Procedure
    from
      VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
      ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
      "Intervention Comfort Measures" ComfortMeasures
      where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) ends 1 day after day of start of QualifyingEncounter.relevantPeriod
        and Coalesce(start of Global."NormalizeInterval"(ComfortMeasures.relevantDatetime, ComfortMeasures.relevantPeriod), ComfortMeasures.authorDatetime)during day of TJC."CalendarDayOfOrDayAfter" (
        end of Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
      return QualifyingEncounter

Note: From CMS108v11 (eCQI, 2023).';

