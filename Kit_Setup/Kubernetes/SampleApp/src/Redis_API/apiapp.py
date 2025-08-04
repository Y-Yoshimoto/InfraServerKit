#!/usr/bin/env python
# coding:utf-8
# モデル読み込み
import os
from fastapi import APIRouter, HTTPException
from .Redis_CONNECTOR.connector import Connector
from .Redis_CONNECTOR.connector import RedisEndpoint


# ログ設定
import logging
logging.basicConfig(level=logging.DEBUG,
                    format="%(asctime)s %(name)s %(filename)s:%(lineno)d %(levelname)s: %(message)s")
logger = logging.getLogger(__name__)

# APIルータ
router = APIRouter(prefix="/redis", tags=["redis"])

# Redis接続情報の設定
config = RedisEndpoint(
    host=os.getenv("ENDPOINT_REDIS"),
    port=6379
)
# コネクタのインスタンスを生成
connector = Connector(config)

@router.get("/keys")
async def get_all_keys():
    """ Redisのすべてのキーを取得 """
    try:
        return {"keys": connector.get_all_keys()}
    except Exception as e:
        logger.error(f"Error getting all keys: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")

@router.get("/keys/count")
async def get_keys_count():
    """ Redisのキーの数を取得 """
    try:
        count = len(connector.get_all_keys())
        return {"count": count}
    except Exception as e:
        logger.error(f"Error getting keys count: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")


@router.get("/get")
async def get_value(key: str):
    """ Redisから値を取得 """
    try:
        value = connector.get(key)
        if value is None:
            raise HTTPException(status_code=404, detail="Key not found")
        return {"key": key, "value": value}
    except Exception as e:
        logger.error(f"Error getting value for key {key}: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")

@router.post("/set")
async def set_value(data: dict):
    """ Redisに値をセット """
    try:
        (key, value, ttl) = (data.get("key"), data.get("value"), data.get("ttl", 30))
        connector.set(key, value, ttl)
        return {"message": f"Set {key} to {value} with TTL {ttl}"}
    except Exception as e:
        logger.error(f"Error setting value: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")
