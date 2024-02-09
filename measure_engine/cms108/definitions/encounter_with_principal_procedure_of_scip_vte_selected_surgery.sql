CREATE OR REPLACE VIEW cms108.encounter_with_principal_procedure_of_scip_vte_selected_surgery AS
SELECT qe.*
FROM vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions AS qe
JOIN (SELECT hadm_id,
             pro ->> 'code'                           AS code,
             (pro ->> 'relevant_datetime')::TIMESTAMP AS relevant_datetime,
             (pro ->> 'relevant_period')::TSRANGE     AS relevant_period
      FROM cms108.scip_vte_selected_surgery    AS ss,
           JSONB_ARRAY_ELEMENTS(ss.procedures) AS pro
      WHERE (pro ->> 'rank')::INT = 1)                                  AS scip ON qe.hadm_id = scip.hadm_id
WHERE global.normalize_interval(scip.relevant_datetime, COALESCE(scip.relevant_period, qe.relevant_period)) && qe.relevant_period;

COMMENT ON VIEW cms108.encounter_with_principal_procedure_of_scip_vte_selected_surgery IS '
Encounter with Principal Procedure of SCIP VTE Selected Surgery
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
      with ( "SCIP VTE Selected Surgery" Procedure
        where Procedure.rank = 1 ) SelectedSCIPProcedure
        such that Global."NormalizeInterval" ( SelectedSCIPProcedure.relevantDatetime, SelectedSCIPProcedure.relevantPeriod ) during QualifyingEncounter.relevantPeriod

Note: From CMS108v11 (eCQI, 2023).';
