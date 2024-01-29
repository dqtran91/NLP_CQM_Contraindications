DROP TABLE IF EXISTS value_set.atrial_fibrillation_flutter;
CREATE TABLE IF NOT EXISTS value_set.atrial_fibrillation_flutter
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
 42731,
 42732
 */