/*
 VTE.FromDayOfStartOfHospitalizationToDayAfterAdmission(Encounter "Encounter, Performed")
 Interval[
    TJC."TruncateTime" ( start of Global."HospitalizationWithObservation" ( Encounter ) ),
    TJC."TruncateTime" ( start of Encounter.relevantPeriod + 2 days )
    )
 */
CREATE OR REPLACE FUNCTION vte.from_day_of_start_of_hospitalization_to_day_after_admission(encounter global.ENCOUNTER_PERFORMED) RETURNS TSRANGE AS
$$
BEGIN
    RETURN TSRANGE(tjc.truncate_time(LOWER(global.hospitalization_with_observation(encounter))),
                   tjc.truncate_time(LOWER(encounter.relevant_period)) + INTERVAL '2 days',
                   '[)');
END;
$$ LANGUAGE plpgsql;
