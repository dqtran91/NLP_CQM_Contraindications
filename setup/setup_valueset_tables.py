import logging
import os.path

from database.sql_utility import SqlOperations

logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)

value_set_folder_path: str = '../measure_engine/value_set'
vsac_folder_path: str = '../data/CMS108_research_valueset/vsac_cache'
icd9_measure_file_path: str = '../data/CMS108_research_valueset/specific_measure_versions.json'


def list_folders(directory_path):
    return [name for name in os.listdir(directory_path) if os.path.isdir(os.path.join(directory_path, name))]


if __name__ == '__main__':
    # create tables
    for folder in list_folders(value_set_folder_path):
        SqlOperations.execute_sql_folder(os.path.join(value_set_folder_path, folder))

    # insert value set data
    SqlOperations.insert_json_into_table(icd9_measure_file_path, vsac_folder_path)

    # insert from custom load scripts
    for folder in list_folders(value_set_folder_path):
        folder_path: str = os.path.join(value_set_folder_path, folder)
        if 'load_scripts' in list_folders(folder_path):
            load_script_folder: str = os.path.join(folder_path, 'load_scripts')
            for script in os.listdir(load_script_folder):
                SqlOperations.execute_sql_file(os.path.join(load_script_folder, script))
