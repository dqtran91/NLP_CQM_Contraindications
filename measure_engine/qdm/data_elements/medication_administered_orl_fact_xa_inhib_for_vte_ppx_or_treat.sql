CREATE OR REPLACE VIEW qdm.medication_administered_orl_fact_xa_inhib_for_vte_ppx_or_treat AS
SELECT ma.subject_id,
       ma.hadm_id,
       JSONB_AGG(meds ORDER BY meds ->> 'relevant_datetime') AS medications
FROM qdm.medication_administered          AS ma,
     JSONB_ARRAY_ELEMENTS(ma.medications) AS meds
WHERE meds ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('oral_factor_xa_inhibitor_for_vte_prophylaxis_or_vte_treatment'))
GROUP BY ma.subject_id, ma.hadm_id;;

COMMENT ON VIEW qdm.medication_administered_orl_fact_xa_inhib_for_vte_ppx_or_treat IS '
QDM Data Element
    Medication
        Medication Administered
            Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment

Note: From CMS (2021)';
