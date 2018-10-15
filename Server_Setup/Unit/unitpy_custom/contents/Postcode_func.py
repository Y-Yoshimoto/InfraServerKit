#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
# mport PostcodeDAO.py as DAO


def InquiryPostcode(environ, start_response):
    start_response('200 OK', [('Content-Type', 'application/json')])
    wsgi_input = environ["wsgi.input"]
    content_length = int(environ.get('CONTENT_LENGTH', 0))
    fromData = wsgi_input.read(content_length)
    # 値の取りだしと判定
    postcode = json.loads(fromData)["Postcode"]
    # result = 0 if number >= 10 else 1
    result = 0
    # data = {'result': result, 'Postcode': postcode}
    # sendData = json.dumps(data, ensure_ascii=False)
    sendData = DateAdress(result, postcode, ["abc"])
    return sendData


# def inquiryDB(postcode):
#        dao = DAO.PostcodeDAO()
#        dao.connectDB
#        adress = dao.selectPostcode(postcode)
#        dao.closeDB()
#        return adress


def DateAdress(result, postcode, adress):
    Data = {"postcodeID": 1,
            "prefectural": "神奈川県",
            "municipality": "川崎市",
            "town": "八丁畷",
            "result": result,
            'Postcode': postcode}
    return json.dumps(Data)

# Data = {"postcodeID": adress[0],
# "prefectural": adress[1],
# "municipality": adress[2],
# "town": adress[3]}
