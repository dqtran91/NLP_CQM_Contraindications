CREATE OR REPLACE VIEW cms108.pharmacological_or_mechanical_vte_prophylaxis_received AS
SELECT ma.subject_id,
       ma.hadm_id,
       JSONB_AGG(meds ORDER BY meds ->> 'relevant_datetime') AS prophylaxes
FROM qdm.medication_administered_low_dose_uf_heparin_for_vte_ppx AS ma,
     JSONB_ARRAY_ELEMENTS(ma.medications)                        AS meds
WHERE meds ->> 'route' IN (SELECT code FROM cql.get_source_mimiciii('subcutaneous_route'))
GROUP BY ma.subject_id, ma.hadm_id
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       medications AS prophylaxes
FROM qdm.medication_administered_low_molecular_wt_heparin_for_vte_ppx
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       medications AS prophylaxes
FROM qdm.medication_administered_inj_fact_xa_inhib_for_vte_ppx
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       medications AS prophylaxes
FROM qdm.medication_administered_warfarin
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       medications AS prophylaxes
FROM qdm.medication_administered_rivaroxaban_for_vte_prophylaxis
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       procedures AS prophylaxes
FROM qdm.procedure_performed_app_of_intermittent_pneu_compress_devices
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       procedures AS prophylaxes
FROM qdm.procedure_performed_app_of_venous_foot_pumps
UNION DISTINCT
SELECT subject_id,
       hadm_id,
       procedures AS prophylaxes
FROM qdm.procedure_performed_app_of_graduated_compress_stockings;


COMMENT ON VIEW cms108.pharmacological_or_mechanical_vte_prophylaxis_received IS '
Pharmacological or Mechanical VTE Prophylaxis Received
    ( ["Medication, Administered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
        where VTEMedication.route in "Subcutaneous route"
    )
      union ["Medication, Administered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
      union ["Medication, Administered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
      union ["Medication, Administered": "Warfarin"]
      union ["Medication, Administered": "Rivaroxaban for VTE Prophylaxis"]
      union ["Procedure, Performed": "Application of Intermittent Pneumatic Compression Devices (IPC)"]
      union ["Procedure, Performed": "Application of Venous Foot Pumps (VFP)"]
      union ["Procedure, Performed": "Application of Graduated Compression Stockings (GCS)"]

Note: From CMS108v11 (eCQI, 2023).';
