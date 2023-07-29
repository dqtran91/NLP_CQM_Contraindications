from pandas import DataFrame, read_sql_query
import sqlalchemy as sa
from sqlalchemy.engine import URL, Engine
from sqlalchemy.sql.elements import TextClause
import yaml


class SqlOperations:
    # load yml file to dictionary
    credentials = yaml.load(open('credentials.yml'))

    # information used to create a sql_alchemy_utility connection
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
        read data from sql_alchemy_utility and return as pandas DataFrame
        """

        read_query: TextClause = sa.text(cls.search_path + sql)

        return read_sql_query(read_query, cls.engine)

    @classmethod
    def write_df_to_db(cls, df: DataFrame, table: str):
        """
        write df to sql_alchemy_utility
        """

        # write back to the sql_alchemy_utility. Heavy operation. Took 30 minutes to complete.
        df.to_sql(table, cls.engine, schema=cls.schema)

    @classmethod
    def drop_table(cls, sql):
        # drop table if exists
        with cls.engine.begin() as connection:
            connection.execute(cls.search_path + sql)
