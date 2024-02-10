DROP TABLE IF EXISTS new_denominator;
CREATE TEMP TABLE IF NOT EXISTS new_denominator AS
SELECT *
FROM vte.encounter_with_age_range_and_without_vte_or_obstetr_conditions
EXCEPT
SELECT *
FROM cms108.denominator_exclusions;

SELECT COUNT(*)
FROM cms108.denominator;
SELECT COUNT(*)
FROM cms108.denominator_exclusions;
SELECT COUNT(*)
FROM new_denominator;

