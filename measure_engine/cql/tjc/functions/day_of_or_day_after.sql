CREATE OR REPLACE FUNCTION tjc.day_of_or_day_after(IN start_value TIMESTAMP, OUT day_of_day_after TSRANGE) RETURNS TSRANGE AS
$$
BEGIN
    SELECT TSRANGE(tjc.truncate_time(start_value), tjc.truncate_time(start_value + INTERVAL '2 days')) INTO day_of_day_after;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION tjc.day_of_or_day_after(IN TIMESTAMP, OUT TSRANGE) IS '
TJC.CalendarDayOfOrDayAfter(StartValue DateTime)
    Interval["TruncateTime"(StartValue), "TruncateTime"(StartValue + 2 days))

Note: From CMS108v11 (eCQI, 2023).';
