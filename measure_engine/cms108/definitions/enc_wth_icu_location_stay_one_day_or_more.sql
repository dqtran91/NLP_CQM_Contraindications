CREATE OR REPLACE VIEW cms108.enc_wth_icu_location_stay_one_day_or_more AS
SELECT *
FROM vte.enc_wth_age_range_and_without_vte_diag_or_obstetrical_conds AS qe
WHERE EXISTS (SELECT 1
              FROM JSONB_ARRAY_ELEMENTS(qe.facility_locations) AS loc
              WHERE loc ->> 'code' in (SELECT code from cql.get_source_mimiciii('intensive_care_unit'))
                AND global.length_in_days(cql.to_tsrange(loc ->> 'location_period')) >= 1
                AND LOWER(cql.to_tsrange(loc ->> 'location_period')) <@
                    TSRANGE(LOWER(qe.relevant_period), tjc.truncate_time(UPPER(qe.relevant_period)) + INTERVAL '2 days', '[)'));

COMMENT ON VIEW cms108.enc_wth_icu_location_stay_one_day_or_more IS '
Encounter with ICU Location Stay 1 Day or More
    VTE."Encounter with Age Range and without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
      where exists ( QualifyingEncounter.facilityLocations Location
          where Location.code in "Intensive Care Unit"
            and Global."LengthInDays" ( Location.locationPeriod ) >= 1
            and Location.locationPeriod starts during Interval[start of QualifyingEncounter.relevantPeriod, TJC."TruncateTime" ( start of QualifyingEncounter.relevantPeriod + 2 days ) )
      )

Note:
    From CMS108v11 (eCQI, 2023). Because MIMIC-III stores mostly ICU stays, all of the location codes are ICU types, except for ward (Johnson et al., 2016)
    Additionally, 76% of MIMIC-III encounters fits this definition, so this view is not used in this research, because it would be too limiting.';
