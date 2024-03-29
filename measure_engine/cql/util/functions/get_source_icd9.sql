CREATE OR REPLACE FUNCTION cql.get_source_icd9(IN value_set TEXT, OUT global.CODE) RETURNS SETOF global.CODE AS
$$
BEGIN
    RETURN QUERY EXECUTE FORMAT('SELECT REPLACE(source_code, ''.'', '''') AS code
        FROM value_set.%I
        WHERE source_system = ''http://hl7.org/fhir/sid/icd-9-cm''', LOWER(value_set));
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION cql.get_source_icd9(IN TEXT, OUT GLOBAL.CODE) IS 'Get the source ICD-9 code set for a given value set that is native to MIMIC-III';
