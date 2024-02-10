# CQL to PostgreSQL Translation Guide
&& is the overlap operator for TSRANGE and is equivalent to 'during' between TSRANGE and TSRANGES

The TSRANGE datatype is equivalent to the CQL Interval values (HL7, 2023, Author's Guide).
- <@ is the contains operator for TSRANGE and is equivalent to `during` between TIMESTAMPS and TSRANGES

# VSAC Guide
Almost all the value sets use the definition version of 20150430 except the following where there was no earlier version available 
, or where the version was the same year but different month and day:
- Application of Graduated Compression Stockings (GCS): 20220212
- Application of Intermittent Pneumatic Compression Devices (IPC): 20220212
- Application of Venous Foot Pumps (VFP): 20220212
- Ethnicity: 20121025
- Intensive Care Unit: 20190305
- Observation Services: 20180321
- ONC Administrative Sex: 20150331
- Payer: 20121025
- Race: 20121025
- Rivaroxaban and Betrixaban for VTE Prophylaxis: 20200305