/* print out schema */
SELECT table_name,
       column_name,
       data_type
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
ALTER COLUMN ndc TYPE BIGINT
USING (ndc::BIGINT);

