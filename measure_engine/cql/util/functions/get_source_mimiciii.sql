CREATE OR REPLACE FUNCTION cql.get_source_mimiciii(IN value_set TEXT, OUT global.CODE) RETURNS SETOF global.CODE AS
$$
BEGIN
    RETURN QUERY EXECUTE FORMAT('SELECT REPLACE(source_code, ''.'', '''') AS code
        FROM value_set.%I
        WHERE source_version = ''2001-2012''', LOWER(value_set));
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION cql.get_source_mimiciii(IN TEXT, OUT GLOBAL.CODE) IS 'Get the source MIMIC-III code set for a given value set that is native to MIMIC-III';
