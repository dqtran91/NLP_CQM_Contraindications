CREATE OR REPLACE FUNCTION global.length_in_days(valueinterval TSRANGE) RETURNS INTEGER AS
$$
BEGIN
    RETURN EXTRACT(DAY FROM UPPER(valueinterval) - LOWER(valueinterval));
END;
$$ LANGUAGE plpgsql;