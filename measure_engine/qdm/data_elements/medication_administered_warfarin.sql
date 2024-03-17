CREATE OR REPLACE VIEW qdm.medication_administered_warfarin AS
SELECT ma.subject_id,
       ma.hadm_id,
       JSONB_AGG(meds ORDER BY meds ->> 'relevant_datetime') AS medications
FROM qdm.medication_administered          AS ma,
     JSONB_ARRAY_ELEMENTS(ma.medications) AS meds
WHERE meds ->> 'code' IN (SELECT code FROM cql.get_source_mimiciii('warfarin'))
GROUP BY ma.subject_id, ma.hadm_id;

COMMENT ON VIEW qdm.medication_administered_warfarin IS '
QDM Data Element
    Medication
        Medication Administered
            Warfarin

Note: From CMS (2021)';
