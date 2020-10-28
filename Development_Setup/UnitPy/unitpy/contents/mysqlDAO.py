#!/usr/bin/env python
# coding:utf-8
import json
import mysql.connector as mydb


# 接続先データベース情報
class PDAO:
    def __init__(self):
        self.connector = mydb.connect(
            host='unit_mariadb',
            port=3306,
            database='shoppinglist',
            user='shoppinglistUser',
            password='Password',
            charset='utf8')
        self.connectDB()
    def __del__(self):
        self.closeDB()

# 接続
    def connectDB(self):
        self.cursor = self.connector.cursor(dictionary=True)
    def connectDB_RAW(self):
        self.cursor = self.connector.cursor()

# 切断
    def closeDB(self):
        self.cursor.close()
        self.connector.close()

# Query
    def selectQuery(self, sqlQuery):
        self.cursor.execute(sqlQuery)
        return self.cursor.fetchall()

    def TransactionQuery(self, sqlQuery):
        # SQL発行
        self.cursor.execute(sqlQuery)
        self.connector.commit()
        return "0"

## DB接続例
# sqlQuery = 'SELECT * FROM t_tablename;'
# dao = DAO.PDAO()
# print(sqlQuery)
# result = dao.selectQuery(sqlQuery)