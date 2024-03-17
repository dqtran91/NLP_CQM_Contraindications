CREATE OR REPLACE VIEW qdm.medication_administered_low_dose_uf_heparin_for_vte_ppx AS
SELECT ma.subject_id,
       ma.hadm_id,
       JSONB_AGG(meds ORDER BY meds ->> 'relevant_datetime') AS medications
FROM qdm.medication_administered AS ma, JSONB_ARRAY_ELEMENTS(ma.medications) AS meds
WHERE meds ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('low_dose_unfractionated_heparin_for_vte_prophylaxis'))
GROUP BY ma.subject_id, ma.hadm_id;

COMMENT ON VIEW qdm.medication_administered_low_dose_uf_heparin_for_vte_ppx IS '
QDM Data Element
    Medication
        Medication Administered
            Low Dose Unfractionated Heparin for VTE Prophylaxis

Note: From CMS (2021)';
