CREATE OR REPLACE VIEW cms108.initial_population AS
SELECT *
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds;

COMMENT ON VIEW cms108.initial_population IS '
Initial Population
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions"

Note: From CMS108v11 (eCQI, 2023).';
