CREATE OR REPLACE FUNCTION global.normalize_interval(IN pointInTime TIMESTAMP, IN period TSRANGE, OUT norm_inter TSRANGE) RETURNS TSRANGE AS
$$
BEGIN
    SELECT CASE
               WHEN pointInTime IS NOT NULL THEN TSRANGE(pointInTime, pointInTime, '[]')
               WHEN period IS NOT NULL      THEN period END
    INTO norm_inter;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION global.normalize_interval(IN TIMESTAMP, IN TSRANGE, OUT TSRANGE) IS '
Global.NormalizeInterval(pointInTime DateTime, period Interval<DateTime>)
    if pointInTime is not null then Interval[pointInTime, pointInTime]
      else if period is not null then period
      else null as Interval<DateTime>

Note: From CMS108v11 (eCQI, 2023).';
