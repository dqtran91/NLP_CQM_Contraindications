import logging
import os.path
from typing import List

from database.sql_utility import SqlOperations

logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)


def match_schema_to_parent_fold(sch: str) -> str:
    """
    Match schema to parent folder
    @param sch: str - schema name
    @return: str - parent folder name
    """
    if sch == 'qdm':
        return 'qdm'
    elif sch == 'global':
        return 'cql'
    elif sch == 'vte':
        return 'cms108'
    elif sch == 'definition':
        return 'cms108'
    elif sch == 'cms108':
        return 'cms108'
    else:
        return ''


if __name__ == '__main__':
    # create tables
    folder_path: str = '../measure_engine'

    sql_table_list: List[str] = [
        'qdm.encounters',
        'global.inpatient_encounter',
        'vte.admission_without_vte_or_obstetrical_conditions',
        'vte.encounter_with_age_range_and_without_vte_or_obstetrical_conds',
        'definition.encounter_less_than_2_days',
        'cms108.initial_population',
        'cms108.denominator',
        'qdm.encounter_performed_emergency_department_visits',
        'qdm.encounter_performed_observation_services',
        'definition.intervention_comfort_measures'
        ]
    for table in sql_table_list:
        # tables are grouped by their schema in folders
        schema: str = table.split('.')[0]
        parent_folder: str = match_schema_to_parent_fold(schema)
        sub_folder_path: str = os.path.join(folder_path, parent_folder)

        # search through the sub-folder to find the sql file
        for root, dirs, files in os.walk(sub_folder_path):
            for file in files:
                if f"{table.split('.')[1]}.sql" == file:
                    SqlOperations.execute_sql_file(os.path.join(root, file))
