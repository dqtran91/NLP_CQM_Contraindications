/*
 Recreate materialized view for knee_replacement_surgery procedure codes.
 value set oid: 2.16.840.1.113883.3.117.1.7.1.261
 url: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.117.1.7.1.261/expansion/
 Code System: ICD-9-PCS
 Inclusion: Includes concepts that represent a procedure for total knee replacement.
 Exclusion: No exclusions.
 note: Because both the inclusion and exclusion criteria are empty, this value set includes codes from 2022 and 2012
 to capture more from the data.
 Used AHRQ (Agency for Healthcare Research and Quality) MapIT to convert ICD-10 to ICD-9 for supplemental value set.
 This is based on the general equivalency mappings (GEMs) from CMS. https://www.cms.gov/medicare/coding/icd10/downloads/icd-10_gem_fact_sheet.pdf
 versions: eCQM Update 2022-05-05 & MU2 Update 2012-10-25
 0070,
 0071,
 0072,
 0073,
 0080,
 0081,
 0082,
 0083,
 0084,
 7609,
 7840,
 7846,
 7860,
 7866,
 7900,
 7920,
 7970,
 7990,
 7999,
 8000,
 8001,
 8002,
 8003,
 8004,
 8005,
 8006,
 8007,
 8008,
 8009,
 8010,
 8016,
 8054,
 8154,
 8155,
 8196,
 8303,
 8394,
 8457,
 8459,
 8466,
 8467,
 8468
 */
DROP TABLE IF EXISTS value_set.knee_replacement_surgery;
CREATE TABLE IF NOT EXISTS value_set.knee_replacement_surgery
(
    system  TEXT NOT NULL,
    version TEXT NOT NULL,
    code    TEXT NOT NULL,
    display TEXT NOT NULL
);