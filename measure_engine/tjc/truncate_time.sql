CREATE OR REPLACE FUNCTION tjc.truncate_time(value_timestamp TIMESTAMP) RETURNS TIMESTAMP AS
$$
BEGIN
    RETURN DATE_TRUNC('day', value_timestamp); -- Truncating to day (midnight)
END;
$$ LANGUAGE plpgsql;
