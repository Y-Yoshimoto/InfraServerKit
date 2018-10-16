#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import PostcodeDAO as DAO


def InquiryPostcode(environ, start_response):
    start_response('200 OK', [('Content-Type', 'application/json')])
    wsgi_input = environ["wsgi.input"]
    content_length = int(environ.get('CONTENT_LENGTH', 0))
    fromData = wsgi_input.read(content_length)
    # 値の取りだしと判定
    postcode = str(json.loads(fromData)["Postcode"])
    adress = inquiryDB(postcode)

    sendData = DateAdress(postcode, adress)
    return sendData


def inquiryDB(postcode):
        dao = DAO.PostcodeDAO()
        dao.connectDB
        adress = dao.selectPostcode(postcode)
        dao.closeDB()
        return adress


def DateAdress(postcode, adress):
    Data = {"postcodeID": adress[0],
            "prefectural": adress[1],
            "municipality": adress[2],
            "town": adress[3],
            "result": adress[4],
            'Postcode': postcode}
    return json.dumps(Data)

# Data = {"postcodeID": adress[0],
# "prefectural": adress[1],
# "municipality": adress[2],
# "town": adress[3]}
