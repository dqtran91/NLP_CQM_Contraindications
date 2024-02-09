CREATE OR REPLACE FUNCTION cql.to_tsrange(IN range_string TEXT, OUT converted_range TSRANGE) AS
$$
DECLARE
    start_ts TIMESTAMP;
    end_ts   TIMESTAMP;
    bounds   CHAR(2);
BEGIN
    SELECT SUBSTRING(range_string FROM '"([^"]+)",')::TIMESTAMP INTO start_ts;
    SELECT SUBSTRING(range_string FROM ',"([^"]+)"')::TIMESTAMP INTO end_ts;

    bounds := CASE
                  WHEN range_string ~ '\[.*\)' THEN '[)'
                  WHEN range_string ~ '\(.*\]' THEN '(]'
                  WHEN range_string ~ '\(.*\)' THEN '()'
                  ELSE '[]' END;

    SELECT TSRANGE(start_ts, end_ts, bounds) INTO converted_range;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION cql.to_tsrange(IN TEXT, OUT TSRANGE) IS 'Converted a string representation of a tsrange to a tsrange.';
