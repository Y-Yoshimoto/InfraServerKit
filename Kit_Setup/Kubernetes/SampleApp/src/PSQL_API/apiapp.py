#!/usr/bin/env python
# coding:utf-8
# モデル読み込み
import os
from fastapi import APIRouter, HTTPException
# DB接続情報のインポート
from .PSQL_CONNECTOR.connSample import DbEndpoint
from .PSQL_CONNECTOR.connector import Connector


# ログ設定
import logging
logging.basicConfig(level=logging.DEBUG,
                    format="%(asctime)s %(name)s %(filename)s:%(lineno)d %(levelname)s: %(message)s")
logger = logging.getLogger(__name__)

# APIルータ
router = APIRouter(prefix="/psql", tags=["psql"])


# DB接続情報の設定
config = DbEndpoint(
    dbname="sampledb",
    user="postgres",
    password="postgres",
    # host="postgres_c",
    host=os.getenv("ENDPOINT_POSTGRES"),
    port=5432
)
# コネクタのインスタンスを生成
connector = Connector(config)

@router.get("/root", include_in_schema=False)
def read_root():
    # Rootパス用
    return {"Path": "/psql/root"}

def query_db(f_query, query: str):
    """
    データベースクエリを実行するヘルパー関数
    Args:
        query (str): 実行するSQLクエリ
    Returns:
        list: クエリ結果のリスト
    """
    try:
        results = connector.execute_select_query(query)
    except Exception as e:
        logger.error(f"Error executing query: {e}")
        raise HTTPException(status_code=503, detail="Database query failed")
    return results

@router.get("/data")
def sample_get():
    """
    Getメソッドのサンプル
    """
    query = "SELECT * FROM request_data;"
    results = query_db(connector.execute_select_query, query)
    return results

@router.get("/data/{id}")
def sample_post(id: int):
    """
    Getメソッドのサンプル
    """
    query = f"SELECT * FROM request_data WHERE id = {id};"
    results = query_db(connector.execute_select_query, query)
    if not results:
        logger.error(f"Data with id {id} not found")
        raise HTTPException(status_code=404, detail="Data not found")
    return results[0]

@router.post("/data")
def sample_put(data: dict):
    """
    Postメソッドのサンプル
    bodyで受け取ったデータをデータベースに挿入する
    """
    if 'message' not in data:
        logger.error("Request body must contain 'message'")
        raise HTTPException(status_code=400, detail="Request body must contain 'message'")
    query = f"INSERT INTO request_data (message) VALUES ('{data['message']}');"
    try:
        connector.execute_commit_query(query)
    except Exception as e:
        logger.error(f"Error executing insert query: {e}")
        raise HTTPException(status_code=503, detail="Insert operation failed")
    return {"message": "Data inserted successfully"}