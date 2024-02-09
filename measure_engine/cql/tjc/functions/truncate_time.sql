CREATE OR REPLACE FUNCTION tjc.truncate_time(IN value_timestamp TIMESTAMP, OUT trunc_time TIMESTAMP) RETURNS TIMESTAMP AS
$$
BEGIN
    SELECT DATE_TRUNC('day', value_timestamp) INTO trunc_time; -- MIMIC does not store timezone offset so truncating to day works.
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION tjc.truncate_time(IN TIMESTAMP, OUT TIMESTAMP) IS '
TJC.TruncateTime(Value DateTime)
    DateTime(year from Value, month from Value, day from Value, 0, 0, 0, 0, timezoneoffset from Value)

Note: From CMS108v11 (eCQI, 2023).';
