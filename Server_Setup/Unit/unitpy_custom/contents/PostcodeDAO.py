#!/usr/bin/env python
# coding:utf-8
# import sys
# sys.path.append('/usr/local/lib/python2.7/dist-packages')
import MySQLdb


# 接続先データベース情報
class PostcodeDAO:
    def __init__(self):
        self.connector = MySQLdb.connect(
                        host="unit_unit_mariadb_1",
                        port=3306,
                        db="unit",
                        user="unit",
                        passwd="unit",
                        charset="utf8")

# 接続
    def connectDB(self):
        self.cursor = self.connector.cursor()

# 切断
    def closeDB(self):
        self.cursor.close()
        self.connector.close()

# サンプル文
    def selectPostcode(self, postcode):
        self.cursor = self.connector.cursor()
        # SQL
        selectPostcodeSQL = "SELECT id,prefectural,municipality,town " + "FROM t_postcode WHERE postcode = " + postcode + ";"
        # print selectPostcodeSQL
        self.cursor.execute(selectPostcodeSQL)
        result = self.cursor.fetchall()
        # print result
        if len(result) < 1:
            userAdress = (0, "存在しません", "", "", 1)
            return userAdress
        userAdress = (result[0][0], result[0][1].encode("utf-8"), result[0][2].encode("utf-8"), result[0][3].encode("utf-8"), 0)

        return userAdress
