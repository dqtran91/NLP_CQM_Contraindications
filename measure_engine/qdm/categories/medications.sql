CREATE OR REPLACE VIEW qdm.medications AS
SELECT subject_id,
       hadm_id,
       JSONB_AGG(JSONB_BUILD_OBJECT('code', drug,
                                    'relevant_datetime', startdate,
                                    'relevant_period', TSRANGE(LEAST(startdate, enddate), enddate, '[]'),
                                    'route', route)
                 ORDER BY startdate) AS medications
FROM mimiciii.prescriptions
GROUP BY subject_id, hadm_id;

COMMENT ON VIEW qdm.medications IS '
QDM Category
    Medications

Note:
    From CMS (2021).';
