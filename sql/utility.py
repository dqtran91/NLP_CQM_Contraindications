import json
import os
from io import TextIOWrapper
from typing import Dict, List

from pandas import DataFrame, read_sql_query
import sqlalchemy as sa
from sqlalchemy.engine import URL, Engine
from sqlalchemy.sql.elements import TextClause
import yaml


class SqlOperations:
    # Load yml file to dictionary
    with open('credentials.yml') as file:
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
            icd9_list: List[str] = json.load(file)['oid']

        for oid in icd9_list:
            with open(os.path.join(vsac_folder_path, oid + '.json'), 'r') as file:
                data: Dict[str, any] = json.load(file)[0]

            # Insert parsed data into the table
            table_name: str = data['name'].replace(' ', '_').lower()
            contains: list = data.get('expansion', {}).get('contains', [{}])

            for item in contains:
                cls.engine.execute(
                    "INSERT INTO value_set.%s (system, version, code, display) VALUES (%s, %s, %s, %s)",
                    (table_name, item.get('system', ''), item.get('version', ''), item.get('code', ''),
                     item.get('display', ''))
                )
