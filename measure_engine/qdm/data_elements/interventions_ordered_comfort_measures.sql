CREATE OR REPLACE VIEW qdm.interventions_ordered_comfort_measures AS
SELECT *
FROM qdm.interventions
LIMIT 0;

COMMENT ON VIEW qdm.interventions_ordered_comfort_measures IS '
QDM Data Element
    Intervention
        Intervention Ordered
            Comfort Measures

Note:
    From CMS (2021). MIMIC-III does not distiguish between interventions ordered and interventions performed.
    Therefore, this view is empty (Johnson et al., 2016)';