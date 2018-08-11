#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json


def get(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return [b"Unit for Wsgi is Up.   Ver 0.02"]


def sendjson(environ, start_response):
    start_response('200 OK', [('Content-Type', 'application/json')])
    sendData = json.dumps({id: 1, name: test}, ensure_ascii=False)
    print sendData
    return sendData


def not_found(environ, start_response):
    start_response('404 Not Found', [('Content-Type', 'text/html')])
    return [b"404 Not Found."]
