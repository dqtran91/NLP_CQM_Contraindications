CREATE OR REPLACE VIEW cms108.denominator AS
SELECT * FROM cms108.initial_population;

COMMENT ON VIEW cms108.denominator IS '
Denominator
    "Initial Population"

Note: From CMS108v11 (eCQI, 2023).'
