/*
 Numerator:

 "Encounter with VTE Prophylaxis Received From Day of Start of Hospitalization To Day After Admission or Procedure"
  union ( "Encounter with Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure"
      intersect ( "Encounter with Prior or Present Diagnosis of Atrial Fibrillation or Prior Diagnosis of VTE"
          union "Encounter with Prior or Present Procedure of Hip or Knee Replacement Surgery"
      )
  )
  union "Encounter with Low Risk for VTE or Anticoagulant Administered"
  union "Encounter with No VTE Prophylaxis Due to Medical Reason"
  union "Encounter with No VTE Prophylaxis Due to Patient Refusal"

  Reference:
    Electronic Clinical Quality Improvement. (May 17, 2023). Venous Thromboembolism Prophylaxis. Population Criteria section. https://ecqi.healthit.gov/sites/default/files/ecqm/measures/CMS108v11.html
 */