import redis
from pydantic import BaseModel

class RedisEndpoint(BaseModel):
    """ Redis接続情報 """
    host: str
    port: int = 6379


class Connector:
    """ Redis接続を管理するクラス """

    def __init__(self, config: RedisEndpoint):
        self.config = config
        self.redis_client = redis.Redis(host=self.config.host, port=self.config.port, decode_responses=True)


    def __del__(self):
        """ コネクションプールを閉じる """
        if self.redis_client:
            self.redis_client.close()
            print("Redis connection closed")

    def set(self, key: str, value: str, ttl: int = 30):
        """ Redisに値をセット """
        self.redis_client.set(key, value, ex=ttl)
        print(f"Set {key} to {value} with TTL {ttl}")

    def get(self, key: str) -> str:
        """ Redisから値を取得 """
        value = self.redis_client.get(key)
        print(f"Get {key} returned {value}")
        return value
    
    def get_all_keys(self, pattern="*"):
        """すべてのキーを取得"""
        keys = self.redis_client.keys(pattern)
        return keys
    
    def delete(self, key: str):
        """ Redisからキーを削除 """
        self.redis_client.delete(key)

        
