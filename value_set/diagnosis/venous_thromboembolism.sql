DROP TABLE IF EXISTS value_set.venous_thromboembolism;
CREATE TABLE IF NOT EXISTS value_set.venous_thromboembolism
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
 41511,
 41513,
 41519,
 45111,
 45119,
 4512,
 45181,
 4519,
 4532,
 45340,
 45341,
 45387,
 45389,
 4539
 */
