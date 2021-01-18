#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
from urllib.parse import parse_qs

############### get 
def get(environ, start_response):
    start_response('200 OK', [('Content-Type', 'application/json')])
    id = parse_qs(environ.get('QUERY_STRING'))['id']
    # レスポンスデータ生成
    result = {"id": int(id[0]), "data": "testData", "other": "test"}
    print(result)
    response = json.dumps(result, ensure_ascii=False).encode('utf-8')
    return response

############### post 
def post(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    wsgi_input = environ["wsgi.input"]
    fromData = wsgi_input.read(int(environ.get('CONTENT_LENGTH', 0))).decode('utf-8')
    print(fromData)
    return [b    res.json(result);
};]

############### put 
def put(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    wsgi_input = environ["wsgi.input"]
    fromData = wsgi_input.read(int(environ.get('CONTENT_LENGTH', 0))).decode('utf-8')
    print(fromData)
    return [b"200 OK."]

############### delete
def delete(environ, start_response):
    start_response('200 OK', [('Content-Type', 'application/json')])
    wsgi_input = environ["wsgi.input"]
    fromData = wsgi_input.read(int(environ.get('CONTENT_LENGTH', 0))).decode('utf-8')
    print(fromData)
    return [b"200 OK."]

    