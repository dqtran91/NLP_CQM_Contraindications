CREATE OR REPLACE VIEW cms108.intervention_comfort_measures AS
SELECT *
FROM qdm.interventions_ordered_comfort_measures
UNION DISTINCT
SELECT *
FROM qdm.interventions_performed_comfort_measures;

COMMENT ON VIEW cms108.intervention_comfort_measures IS '
Intervention Comfort Measures
    ["Intervention, Order": "Comfort Measures"]
    union ["Intervention, Performed": "Comfort Measures"]

Note: From CMS108v11 (eCQI, 2023). ';
