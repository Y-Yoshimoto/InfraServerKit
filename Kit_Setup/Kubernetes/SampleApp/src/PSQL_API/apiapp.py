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
        return connector.execute_select_query(query)
    except Exception as e:
        logger.error(f"Error executing query: {e}")
        raise HTTPException(status_code=503, detail="Database query failed")

# 全データ取得
@router.get("/data")
def sample_get():
    """
    Getメソッドのサンプル
    """
    query = "SELECT * FROM request_data;"
    results = query_db(connector.execute_select_query, query)
    return [{"id": record[0], "message": record[1], "created_at": record[2]} for record in results]

# データ件数取得
@router.get("/data/count")
def sample_get_count():
    """
    Getメソッドのサンプル
    """
    query = "SELECT COUNT(*) FROM request_data;"
    results = query_db(connector.execute_select_query, query)
    return {"count": results[0][0]}

# ID指定でデータ取得
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
    r = results[0]
    return {"id": r[0], "message": r[1], "created_at": r[2]}

# データ挿入
@router.post("/data")
def sample_put(data: dict):
    """
    Postメソッドのサンプル
    bodyで受け取ったデータをデータベースに挿入する
    """
    if 'message' not in data:
        logger.error("Request body must contain 'message'")
        raise HTTPException(status_code=400, detail="Request body must contain 'message'")
    query = f"INSERT INTO request_data (message) VALUES ('{data['message']}') RETURNING id;"
    try:
        inserted_id = connector.execute_commit_query(query)
        return {"id": inserted_id}
    except Exception as e:
        logger.error(f"Error executing insert query: {e}")
        raise HTTPException(status_code=503, detail="Insert operation failed")

# データ削除
@router.delete("/data/clear")
def sample_delete():
    """
    データベースのrequest_dataテーブルをクリアする
    """
    query = "DELETE FROM request_data;"
    try:
        connector.execute_commit_query(query)
        return {"status": "success", "message": "All data cleared"}
    except Exception as e:
        logger.error(f"Error executing delete query: {e}")
        raise HTTPException(status_code=503, detail="Delete operation failed")
