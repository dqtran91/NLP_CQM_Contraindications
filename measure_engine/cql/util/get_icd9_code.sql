CREATE OR REPLACE FUNCTION cql.get_icd9_code(schema_name TEXT, table_name TEXT)
    RETURNS TABLE
            (
                CODE TEXT
            )
AS
$$
BEGIN
    RETURN QUERY EXECUTE FORMAT('SELECT REPLACE(standard_code, ''.'', '''') AS code
        FROM %I.%I
        WHERE standard_system = ''http://hl7.org/fhir/sid/icd-9-cm''', LOWER(schema_name), LOWER(table_name));
END;
$$ LANGUAGE plpgsql;