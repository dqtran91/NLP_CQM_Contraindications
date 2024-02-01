CREATE OR REPLACE FUNCTION cql.normalize_interval(pointintime TIMESTAMP, period TSRANGE) RETURNS TSRANGE AS
$$
DECLARE
    result TSRANGE;
BEGIN
    IF pointintime IS NOT NULL THEN
        result := TSRANGE(pointintime, pointintime, '[]');
    ELSIF period IS NOT NULL THEN
        result := period;
    ELSE
        result := NULL;
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cql.to_tsrange(range_string TEXT) RETURNS TSRANGE AS
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

    RETURN TSRANGE(start_ts, end_ts, bounds);
END;
$$ LANGUAGE plpgsql;
