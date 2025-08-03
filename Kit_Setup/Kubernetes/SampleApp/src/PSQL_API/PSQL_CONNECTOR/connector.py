import psycopg
import psycopg_pool
from pydantic import BaseModel

class DbEndpoint(BaseModel):
    """ データベース接続情報 """
    dbname: str
    user: str
    password: str
    host: str
    port: int = 5432

    def getEndpointString(self) -> str:
        return f"dbname={self.dbname} user={self.user} password={self.password} host={self.host} port={self.port}"

class Connector:
    """ データベース接続を管理するクラス """
    min_size: int = 1
    max_size: int = 3

    def __init__(self, config: DbEndpoint):
        self.config = config
        try:
            self.pool = self._gen_connection_pool(config)
        except psycopg.OperationalError as e:
            print(f"Connection error: {e}")
            self.pool = None
            raise e

    def __del__(self):
        """ コネクションプールを閉じる """
        if self.pool:
            self.pool.close()
            print("Connection pool closed")

    def _gen_connection_pool(self, _config: DbEndpoint):
        """ コネクションプールを生成する """
        return psycopg_pool.ConnectionPool(conninfo=_config.getEndpointString(), min_size=self.min_size, max_size=self.max_size)

    def _gen_async_connection_pool(self, _config: DbEndpoint):
        """ 非同期コネクションプールを生成する """
        # https://www.psycopg.org/psycopg3/docs/advanced/pool.html#other-ways-to-create-a-pool
        return psycopg_pool.AsyncConnectionPool(conninfo=_config.getEndpointString(), min_size=self.min_size, max_size=self.max_size)

    def execute_select_query(self, query: str):
        """ SELECTクエリを実行する """
        print(f"Executing query: {query}", flush=True)
        print(f"Using connection pool: {self.pool}", flush=True)
        with self.pool.connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query)
                return cur.fetchall()

    def execute_commit_query(self, query: str):
        """ INSERTクエリを実行する """
        with self.pool.connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query)
                conn.commit()