-- Create a temporary table with a JSONB column
drop table if exists PatientEncounters;
CREATE TEMP TABLE PatientEncounters (
    patient_id INT,
    diagnoses JSONB
);

-- Insert sample data into PatientEncounters
INSERT INTO PatientEncounters (patient_id, diagnoses)
VALUES
    (1, '[{"code": "123", "description": "Diagnosis 123"}]'),
    (2, '[{"code": "456", "description": "Diagnosis 456"}]'),
    (3, '[{"code": "789", "description": "Diagnosis 789"}]');


-- Use NOT EXISTS to find records where a specific code doesn't exist in diagnoses
SELECT *
FROM PatientEncounters AS pe
WHERE NOT EXISTS (
    SELECT 1
    FROM JSONB_ARRAY_ELEMENTS(pe.diagnoses) AS diagnosis
    WHERE diagnosis->>'code' = '123'
);
