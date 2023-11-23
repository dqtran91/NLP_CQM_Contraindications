/*
 Recreate materialized view for patient-refusal value-set codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.93
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.93/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that identify a negation rationale for refusal of any intervention.
 Exclusion: No exclusions
 note: The available open-source snomed-to-icd did not gave results for the snomed code in this value set,
 so there are no results for this value set.
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.patient_refusal;
CREATE MATERIALIZED VIEW value_set.patient_refusal AS
SELECT NULL AS patient_refusal;

select * from inputevents_cv limit 100;

select *
from inputevents_mv
where statusdescription = 'Stopped'
limit 100;

select *
from inputevents_mv
where cancelreason = 1
limit 100;

select *
from inputevents_mv
where cancelreason = 2
limit 100;

select DISTINCT warning
from chartevents;

select distinct error
from chartevents;

select distinct resultstatus
from chartevents;

select DISTINCT stopped from chartevents;

select DISTINCT cancelreason from inputevents_mv;
select DISTINCT statusdescription from inputevents_mv;

select DISTINCT cancelreason from procedureevents_mv;
select DISTINCT statusdescription from procedureevents_mv;
