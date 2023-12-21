CREATE OR REPLACE FUNCTION cql.normalize_interval(pointInTime TIMESTAMP, period TSRANGE) RETURNS TSRANGE AS
$$
DECLARE
    result TSRANGE;
BEGIN
    IF pointInTime IS NOT NULL THEN
        result := TSRANGE(pointInTime, pointInTime, '[]');
    ELSIF period IS NOT NULL THEN
        result := period;
    ELSE
        result := NULL;
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cql.length_in_days(valueInterval TSRANGE) RETURNS INTEGER AS
$$
BEGIN
    RETURN EXTRACT(DAY FROM UPPER(valueInterval) - LOWER(valueInterval));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cql.get_icd9_code(schema_name TEXT, table_name TEXT) RETURNS TABLE(code TEXT) AS $$
BEGIN
    RETURN QUERY EXECUTE format(
        'SELECT REPLACE(code, ''.'', '''') AS code
        FROM %I.%I
        WHERE system = ''http://hl7.org/fhir/sid/icd-9-cm''', LOWER(schema_name), LOWER(table_name)
    );
END;
$$ LANGUAGE plpgsql;
