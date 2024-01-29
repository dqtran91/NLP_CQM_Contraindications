/*
 - Global.HospitalizationWithObservation(Encounter "Encounter, Performed"):
 Encounter Visit
 let ObsVisit: Last(
            ["Encounter, Performed": "Observation Services"] LastObs
            where LastObs.relevantPeriod ends 1 hour or less on or before start of Visit.relevantPeriod
            sort by end of relevantPeriod
 ),
 VisitStart: Coalesce(start of ObsVisit.relevantPeriod, start of Visit.relevantPeriod),
 EDVisit: Last(
            ["Encounter, Performed": "Emergency Department Visit"] LastED
            where LastED.relevantPeriod ends 1 hour or less on or before VisitStart
            sort by end of relevantPeriod
 )
 return Interval[Coalesce(start of EDVisit.relevantPeriod, VisitStart), end of Visit.relevantPeriod]
 */
CREATE TYPE global.ENCOUNTER_PERFORMED AS
(
    hadm_id         INTEGER,
    relevant_period TSRANGE
);

CREATE OR REPLACE FUNCTION global.hospitalization_with_observation(visit global.ENCOUNTER_PERFORMED) RETURNS TSRANGE AS
$$
DECLARE
    obs_visit   TSRANGE;
    visit_start TIMESTAMP;
    ed_visit    TSRANGE;
BEGIN
    SELECT last_obs.relevant_period
    INTO obs_visit
    FROM data_elements.encounter_performed_observation_services AS last_obs
    WHERE last_obs.hadm_id = visit.hadm_id AND
          UPPER(last_obs.relevant_period) - INTERVAL '1 HOUR' <= LOWER(visit.relevant_period)
    ORDER BY UPPER(last_obs.relevant_period) DESC
    LIMIT 1;

    SELECT COALESCE(LOWER(obs_visit), LOWER(visit.relevant_period)) INTO visit_start;

    SELECT last_ed.relevant_period
    INTO ed_visit
    FROM data_elements.encounter_performed_emergency_department_visits AS last_ed
    WHERE last_ed.hadm_id = visit.hadm_id AND UPPER(last_ed.relevant_period) - INTERVAL '1 HOUR' <= LOWER(visit_start)
    ORDER BY UPPER(last_ed.relevant_period) DESC;

    RETURN TSRANGE(COALESCE(LOWER(ed_visit), visit_start), UPPER(visit.relevant_period), '[]');
END;
$$ LANGUAGE plpgsql;

