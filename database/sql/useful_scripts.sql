/* print out schema */
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
  AND table_name NOT IN ('noteevents_05012023', 'inputevents_mv', 'inputevents_cv', 'ignore_item_id')
ORDER BY table_schema, table_name, ordinal_position;

/* check if a column contain non-int values */
SELECT ndc
FROM prescriptions
WHERE ndc !~ '^[0-9]+$';

/* Change data type of a column */
ALTER TABLE prescriptions
    ALTER COLUMN ndc TYPE BIGINT USING (ndc::BIGINT);

/* search for column*/
SELECT t.table_schema, t.table_name, c.column_name
FROM information_schema.tables        t
INNER JOIN information_schema.columns c ON c.table_name = t.table_name AND c.table_schema = t.table_schema
WHERE c.column_name LIKE '%location%'
  AND t.table_schema NOT IN ('information_schema', 'pg_catalog')
  AND t.table_type = 'BASE TABLE'
ORDER BY t.table_schema;

/* search for all materialized views */
SELECT matviewname FROM pg_catalog.pg_matviews;


/* drop all materialized views */
DO $$
DECLARE
    view_name TEXT;
BEGIN
    FOR view_name IN
        SELECT schemaname || '.' || matviewname
        FROM pg_catalog.pg_matviews
    LOOP
        EXECUTE 'DROP MATERIALIZED VIEW ' || view_name || ';';
        RAISE NOTICE 'Dropped materialized view: %', view_name;
    END LOOP;
END $$;
