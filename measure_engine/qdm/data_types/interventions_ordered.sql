CREATE OR REPLACE VIEW qdm.interventions_ordered AS
SELECT *
FROM qdm.interventions
LIMIT 0;

COMMENT ON VIEW qdm.interventions_ordered IS '
QDM Data Type
    Intervention
        Intervention Ordered

Note:
    From CMS (2021). MIMIC-III does not distinguish between interventions ordered and interventions performed.
    Therefore, this view is empty (Johnson et al., 2016)';
