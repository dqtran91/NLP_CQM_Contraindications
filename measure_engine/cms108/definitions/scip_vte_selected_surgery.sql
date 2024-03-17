CREATE OR REPLACE VIEW cms108.scip_vte_selected_surgery AS
SELECT q.hadm_id,
       q.subject_id,
       JSONB_AGG(JSONB_BUILD_OBJECT('code', p ->> 'code',
                                    'rank', (p ->> 'rank')::INT,
                                    'relevant_datetime', p ->> 'relevant_datetime',
                                    'relevant_period', p ->> 'relevant_period')
                 ORDER BY (p ->> 'rank')::INT) AS procedures
FROM qdm.procedures                     AS q,
     JSONB_ARRAY_ELEMENTS(q.procedures) AS p
WHERE p ->> 'code' IN (SELECT code
                       FROM cql.get_standard_icd9('general_surgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('gynecological_surgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('hip_fracture_surgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('hip_replacement_surgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('intracranial_neurosurgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('knee_replacement_surgery')
                       UNION DISTINCT
                       SELECT code
                       FROM cql.get_standard_icd9('urological_surgery'))
GROUP BY q.hadm_id, q.subject_id;

COMMENT ON VIEW cms108.scip_vte_selected_surgery IS '
SCIP VTE Selected Surgery
    //SCIP stands for Surgical Care Improvement Project
    ["Procedure, Performed": "General Surgery"]
      union ["Procedure, Performed": "Gynecological Surgery"]
      union ["Procedure, Performed": "Hip Fracture Surgery"]
      union ["Procedure, Performed": "Hip Replacement Surgery"]
      union ["Procedure, Performed": "Intracranial Neurosurgery"]
      union ["Procedure, Performed": "Knee Replacement Surgery"]
      union ["Procedure, Performed": "Urological Surgery"]

Note: From CMS108v11 (eCQI, 2023).';
