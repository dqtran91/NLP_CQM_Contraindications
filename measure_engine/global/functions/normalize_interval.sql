/*
 Global.NormalizeInterval(pointInTime DateTime, period Interval<DateTime>)
if pointInTime is not null then Interval[pointInTime, pointInTime]
  else if period is not null then period
  else null as Interval<DateTime>
 */
CREATE OR REPLACE FUNCTION global.normalize_interval(pointInTime TIMESTAMP, period TSRANGE) RETURNS TSRANGE AS
$$
BEGIN
    RETURN CASE
        WHEN pointInTime IS NOT NULL THEN TSRANGE(pointInTime, pointInTime, '[]')
        WHEN period IS NOT NULL THEN period
    END;
END;
$$ LANGUAGE plpgsql;