CREATE OR REPLACE FUNCTION vte.from_hosp_start_day_to_day_after_admission(IN encounter global.ENCOUNTER_PERFORMED, OUT hosp_period TSRANGE) RETURNS TSRANGE AS
$$
BEGIN
    SELECT TSRANGE(tjc.truncate_time(LOWER(global.hospitalization_with_observation(encounter))),
                   tjc.truncate_time(LOWER(encounter.relevant_period)) + INTERVAL '2 days', '[)')
    INTO hosp_period;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION vte.from_hosp_start_day_to_day_after_admission(IN global.ENCOUNTER_PERFORMED, OUT TSRANGE) IS '
VTE.FromDayOfStartOfHospitalizationToDayAfterAdmission(Encounter "Encounter, Performed")
    Interval[TJC."TruncateTime" ( start of Global."HospitalizationWithObservation" ( Encounter ) ), TJC."TruncateTime" ( start of Encounter.relevantPeriod + 2 days ) )

Note:FROM CMS108v11 (eCQI, 2023).';
