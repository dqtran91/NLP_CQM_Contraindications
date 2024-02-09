# NLP_CQM_Contraindications
NLP project to identify contraindications to improve clinical quality measures

## Project Overview
To calculate electronic clinical quality (eCQM) measures off structured data, the data must be mapped to the Quality Data Model (QDM) 
and the Clinical Quality Language (Centers for Medicare & Medicaid Services [CMS], 2021; Health Level Seven International [Hl7], 2023). 
The QDM is a model for representing clinical concepts in a structured format. The CQL is a language for representing clinical knowledge in a structured format.

Several measures, (electronic clinical improvement [eCQI], 2023) for this project have their QDM and CQL converted to SQL.

The goal is to identify contraindications to the measures. The project is based off the MIMIC-III database.



# Setup

- In the cql-exec-vsac Node.js project
  - run [parse_valueset_for_specific_version.js](..%2Fcql-exec-vsac%2Fcustom%2Futility%2Fparse_valueset_for_specific_version.js)
  - run [download_specific_version_valuesets.js](..%2Fcql-exec-vsac%2Fcustom%2Futility%2Fdownload_specific_version_valuesets.js)
- run [setup_valueset_tables.py](setup%2Fsetup_valueset_tables.py).py to insert value set code into the database
- run [setup_measure_tables.py](setup%2Fsetup_measure_tables.py).py to create the QMD and CQL tables.


