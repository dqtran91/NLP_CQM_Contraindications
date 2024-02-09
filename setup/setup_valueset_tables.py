import logging
import os.path
from typing import List

from database.sql_utility import SqlOperations

logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)

if __name__ == '__main__':
    # create tables
    value_set_folder_path: str = '../measure_engine/value_set'
    sql_creation_folders: List[str] = ['diagnosis', 'encounter', 'procedure']
    for folder in sql_creation_folders:
        SqlOperations.execute_sql_folder(os.path.join(value_set_folder_path, folder))

    # insert value set data
    vsac_folder_path: str = '../data/CMS108_research_valueset/vsac_cache'
    icd9_measure_file_path: str = '../data/CMS108_research_valueset/icd9_measure.json'
    SqlOperations.insert_json_into_table(icd9_measure_file_path, vsac_folder_path)
