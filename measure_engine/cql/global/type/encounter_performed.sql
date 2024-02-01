/*
 Represent an encounter performed. Used in functions
 */
CREATE TYPE global.ENCOUNTER_PERFORMED AS
(
    hadm_id         INTEGER,
    relevant_period TSRANGE
);