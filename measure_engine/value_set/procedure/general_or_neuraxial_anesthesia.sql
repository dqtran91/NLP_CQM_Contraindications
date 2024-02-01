DROP TABLE IF EXISTS value_set.general_or_neuraxial_anesthesia;
CREATE TABLE IF NOT EXISTS value_set.general_or_neuraxial_anesthesia
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
/*3726, 4233, 668, 6695, 9912, 9913, 9923, 9927, 9929, 9975*/


