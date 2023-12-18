/**********************************************
 Population Criteria:
 Numerator
    "Encounter with VTE Prophylaxis Received From Day of Start of Hospitalization To Day After Admission or Procedure"
    union ( "Encounter with Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure"
        intersect ( "Encounter with Prior or Present Diagnosis of Atrial Fibrillation or Prior Diagnosis of VTE"
          union "Encounter with Prior or Present Procedure of Hip or Knee Replacement Surgery") )
    union "Encounter with Low Risk for VTE or Anticoagulant Administered"
    union "Encounter with No VTE Prophylaxis Due to Medical Reason"
    union "Encounter with No VTE Prophylaxis Due to Patient Refusal"
 **********************************************/
/*
 Definitions:
 Encounter with VTE Prophylaxis Received From Day of Start of Hospitalization To Day After Admission or Procedure
    ( VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
        with "Pharmacological or Mechanical VTE Prophylaxis Received" VTEProphylaxis
        such that Global."NormalizeInterval" ( VTEProphylaxis.relevantDatetime, VTEProphylaxis.relevantPeriod )
            starts during day of VTE."FromDayOfStartOfHospitalizationToDayAfterAdmission" ( QualifyingEncounter ))
    union ( from
        VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
        ["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
        "Pharmacological or Mechanical VTE Prophylaxis Received" VTEProphylaxis
        where Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod )
                ends 1 day after day of start of QualifyingEncounter.relevantPeriod
            and Global."NormalizeInterval" ( VTEProphylaxis.relevantDatetime, VTEProphylaxis.relevantPeriod )
                starts during day of TJC."CalendarDayOfOrDayAfter" (
            end of Global."NormalizeInterval" ( AnesthesiaProcedure.relevantDatetime, AnesthesiaProcedure.relevantPeriod ) )
        return QualifyingEncounter )

 Pharmacological or Mechanical VTE Prophylaxis Received
    ( ["Medication, Administered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
        where VTEMedication.route in "Subcutaneous route")
    union ["Medication, Administered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
    union ["Medication, Administered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
    union ["Medication, Administered": "Warfarin"]
    union ["Medication, Administered": "Rivaroxaban for VTE Prophylaxis"]
    union ["Procedure, Performed": "Application of Intermittent Pneumatic Compression Devices (IPC)"]
    union ["Procedure, Performed": "Application of Venous Foot Pumps (VFP)"]
    union ["Procedure, Performed": "Application of Graduated Compression Stockings (GCS)"]
 */
SELECT *
FROM encounter_without_vte_or_obstetrical_diagnosis QualifyingEncounter
JOIN (
    SELECT hadm_id
    FROM value_set.low_dose_unfractionated_heparin_vte
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.low_molecular_weight_heparin_vte
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.injectable_factor_xa_inhibitors_vte
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.warfarin
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.rivaroxaban_vte
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.intermittent_pneumatic_compression_devices_applied
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.venous_foot_pumps_ordered
    UNION DISTINCT
    SELECT hadm_id
    FROM value_set.graduated_compression_stockings_applied
    ) vte_prophylaxis_received ON QualifyingEncounter.hadm_id = vte_prophylaxis_received.hadm_id