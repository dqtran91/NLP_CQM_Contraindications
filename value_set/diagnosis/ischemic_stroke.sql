DROP TABLE IF EXISTS value_set.ischemic_stroke;
CREATE TABLE IF NOT EXISTS value_set.ischemic_stroke
(
    id               BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    source_system    TEXT,
    source_version   TEXT,
    source_code      TEXT,
    source_display   TEXT,
    standard_system  TEXT,
    standard_version TEXT,
    standard_code    TEXT,
    standard_display TEXT
);
/*
 SELECT * FROM value_set.ischemic_stroke;
 43301,
 43310,
 43311,
 43321,
 43331,
 43381,
 43391,
 43400,
 43401,
 43411,
 43491,
 436
 */
