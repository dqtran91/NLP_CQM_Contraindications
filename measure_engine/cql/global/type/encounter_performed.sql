CREATE TYPE global.ENCOUNTER_PERFORMED AS
(
    hadm_id         INTEGER,
    relevant_period TSRANGE
);

COMMENT ON TYPE global.ENCOUNTER_PERFORMED IS 'Represent an encounter performed. Used in functions';
