CREATE OR REPLACE FUNCTION CQL.NormalizeInterval(pointInTime TIMESTAMP, period TSRANGE) RETURNS TSRANGE AS
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

CREATE OR REPLACE FUNCTION CQL.LengthInDays(valueInterval TSRANGE) RETURNS INTEGER AS
$$
BEGIN
    RETURN EXTRACT(DAY FROM UPPER(valueInterval) - LOWER(valueInterval));
END;
$$ LANGUAGE plpgsql;

