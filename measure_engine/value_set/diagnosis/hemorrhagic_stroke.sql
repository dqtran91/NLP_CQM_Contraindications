DROP TABLE IF EXISTS value_set.hemorrhagic_stroke;
CREATE TABLE IF NOT EXISTS value_set.hemorrhagic_stroke
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
 430
 431
 */