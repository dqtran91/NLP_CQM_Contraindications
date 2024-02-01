/*
 TJC.CalendarDayOfOrDayAfter(StartValue DateTime)
    Interval["TruncateTime"(StartValue), "TruncateTime"(StartValue + 2 days))
 */
 CREATE OR REPLACE FUNCTION tjc.calendar_day_of_or_day_after(start_value TIMESTAMP) RETURNS TSRANGE AS
 $$
 BEGIN
    RETURN TSRANGE(tjc.truncate_time(start_value), tjc.truncate_time(start_value + INTERVAL '2 days'));
 END;
 $$ LANGUAGE plpgsql;