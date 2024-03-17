# NLP_CQM_Contraindications
NLP project to identify contraindications to improve clinical quality measures

## Project Overview
The goal is to identify contraindications to the measures. The project is based off the MIMIC-III database (Johnson et al., 2016).

The structure data is mapped to the Quality Data Model (QDM) and processed using the Clinical Quality Language (CQL) to calculate 
electronic clinical quality (eCQM) measures (Centers for Medicare & Medicaid Services [CMS], 2021; electronic clinical improvement [eCQI],
2023; Health Level Seven International [Hl7], 2023). 

The value sets came from the Value Set Authority Center (VSAC) repository website (National Library of Medicine [NLM], 2023).

The measures are defined via an expression logical model (ELM) format (eCQI, 2023).

# Setup

- In the cql-exec-vsac Node.js project
  - run [parse_valueset_for_specific_version.js](..%2Fcql-exec-vsac%2Fcustom%2Futility%2Fparse_valueset_for_specific_version.js)
  - run [download_specific_version_valuesets.js](..%2Fcql-exec-vsac%2Fcustom%2Futility%2Fdownload_specific_version_valuesets.js)
- run [setup_valueset_tables.py](setup%2Fsetup_valueset_tables.py).py to insert value set code into the database
- run [setup_measure_tables.py](setup%2Fsetup_measure_tables.py).py to create the QMD and CQL tables.


