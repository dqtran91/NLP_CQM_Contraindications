import json
import logging
import os
import re
from typing import Dict, List, Generator

import sqlalchemy as sa
import yaml
from pandas import DataFrame, read_sql_query
from sqlalchemy.engine import URL, Engine
from sqlalchemy.sql.elements import TextClause


class SqlOperations:
    # Load yml file to dictionary
    with open('../credentials.yml') as file:
        credentials = yaml.load(file, Loader=yaml.FullLoader)

    # information used to create a sql connection
    sql_user: str = credentials['database']['username']
    sql_pass: str = credentials['database']['password']
    dbname: str = 'mimic'
    schema: str = 'mimiciii'
    search_path: str = 'set search_path to ' + schema + ';'

    url: URL = URL.create(
        drivername="postgresql",
        username=sql_user,
        password=sql_pass,
        database=dbname
    )
    engine: Engine = sa.create_engine(url)

    @classmethod
    def select_db(cls, sql: str) -> DataFrame:
        """
        read data from sql and return as pandas DataFrame
        """

        read_query: TextClause = sa.text(cls.search_path + sql)

        return read_sql_query(read_query, cls.engine)

    @classmethod
    def write_df_to_db(cls, df: DataFrame, table: str) -> None:
        """
        write df to sql
        """

        df.to_sql(table, cls.engine, schema=cls.schema)

    @classmethod
    def drop_table(cls, sql: str) -> None:
        """
        drop table if exists
        """
        with cls.engine.begin() as connection:
            connection.execute(cls.search_path + sql)

    @classmethod
    def insert_json_into_table(cls, icd9_file_path: str, vsac_folder_path: str) -> None:
        """
        Read the icd9 measures to know which value sets to load into the database
        """
        with open(icd9_file_path, 'r') as file:
            icd9_list: List[Dict[str, str]] = json.load(file)

        for oid in icd9_list:
            with open(os.path.join(vsac_folder_path, oid.get('oid') + '.json'), 'r') as file:
                data_list: List[Dict[str, any]] = json.load(file)

            table_name: str = data_list[0]['title'].replace(' ', '_').lower()

            raw_value_set_list: List[Dict[str, str]] = []
            for data in data_list:
                raw_value_set_list.extend(data.get('expansion', {}).get('contains', [{}]))

            # deduplicate same value sets
            value_set_list: List[Dict[str, str]] = cls.deduplicate_value_set(raw_value_set_list)

            # Insert parsed data into the table
            for item in value_set_list:
                cls.engine.execute(
                    f"INSERT INTO value_set.{table_name} "
                    f"(standard_system, standard_version, standard_code, standard_display) VALUES (%s, %s, %s, %s)",
                    (item.get('system', ''), item.get('version', ''), item.get('code', ''), item.get('display', ''))
                )
            logging.info(f"Inserted codes into {table_name}")

    @classmethod
    def deduplicate_value_set(cls, raw_value_set_list: List[Dict[str, str]]) -> List[Dict[str, str]]:
        """
        Deduplicate value set list
        """
        value_set_list: List[Dict[str: str]] = []
        for item in raw_value_set_list:
            if item not in value_set_list:
                value_set_list.append(item)
        return value_set_list


    @classmethod
    def execute_sql_files(cls, folder_path) -> None:
        """
        Execute all sql files in a folder
        """
        sql_files: Generator[str, None, None] = (os.path.join(folder_path, file_name)
                                                 for file_name in os.listdir(folder_path) if file_name.endswith(".sql"))
        for file_name in sql_files:
            with open(file_name, 'r') as file:
                # Remove /* ... */ style comments
                sql_script: str = re.sub(r'/\*.*?\*/', '', file.read(), flags=re.DOTALL)

            cls.engine.execute(sql_script)
            logging.info(f"Executed {file_name}")
