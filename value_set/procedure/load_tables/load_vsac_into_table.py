from sql.utility import SqlOperations

if __name__ == '__main__':
    # Example JSON data and table name
    vsac_folder_path = 'data/CMS108_research_valueset/vsac_cache'
    icd9_measure_file_path = 'data/CMS108_research_valueset/icd9_measure.json'

    # Call function to insert JSON data into the table
    SqlOperations.insert_json_into_table(icd9_measure_file_path, vsac_folder_path)
