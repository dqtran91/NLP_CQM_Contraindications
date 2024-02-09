CREATE OR REPLACE FUNCTION global.length_in_days(IN value_interval TSRANGE, OUT length INTEGER) RETURNS INTEGER AS
$$
BEGIN
    SELECT EXTRACT(DAY FROM UPPER(value_interval) - LOWER(value_interval)) INTO length;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION global.length_in_days(IN TSRANGE, OUT INTEGER) IS '
Global.LengthInDays(Value Interval<DateTime>)
    difference in days between start of Value and end of Value

Note: From CMS108v11 (eCQI, 2023).';
