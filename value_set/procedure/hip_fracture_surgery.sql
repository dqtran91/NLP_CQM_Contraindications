DROP TABLE IF EXISTS value_set.hip_fracture_surgery;
CREATE TABLE value_set.hip_fracture_surgery
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
 7970,
 7971,
 7972,
 7973,
 7974,
 7979,
 8140,
 8147,
 8149,
 8196
 */
