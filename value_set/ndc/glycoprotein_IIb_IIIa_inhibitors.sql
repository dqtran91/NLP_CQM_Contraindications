/*
 Recreate materialized view for medications to identify glycoprotein Iib/IIIa inhibitors.
 value set oid: 2.16.840.1.113762.1.4.1045.41
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1045.41/expansion/eCQM%20Update%202022-05-05
 Definition version: 20210220
 Inclusion: Includes concepts that represent a medication that is a glycoprotein Iib/IIIa inhibitor.
 Exclusion: No exclusions
 */
DROP MATERIALIZED VIEW IF EXISTS value_set.glycoprotein_iib_iiia_inhibitors;
CREATE MATERIALIZED VIEW IF NOT EXISTS value_set.glycoprotein_iib_iiia_inhibitors AS
SELECT distinct drug
FROM mimiciii.prescriptions
WHERE LOWER(drug) LIKE '%eptifibatide%'
   OR LOWER(drug_name_poe) LIKE '%eptifibatide%'
   OR LOWER(drug_name_generic) LIKE '%eptifibatide%'
   OR LOWER(drug) LIKE '%tirofiban%'
   OR LOWER(drug_name_poe) LIKE '%tirofiban%'
   OR LOWER(drug_name_generic) LIKE '%tirofiban%'
   OR LOWER(drug) LIKE '%abciximab%'
   OR LOWER(drug_name_poe) LIKE '%abciximab%'
   OR LOWER(drug_name_generic) LIKE '%abciximab%';