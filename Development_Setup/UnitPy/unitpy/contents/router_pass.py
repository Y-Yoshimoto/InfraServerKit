#!/usr/bin/env python
# -*- coding: utf-8 -*-
import functions as functions

## alive
def alive(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return [b"Unit for Wsgi is Up."]

## not_found
def not_found(environ, start_response):
    start_response('404 Not Found', [('Content-Type', 'text/html')])
    return [b"404 Not Found."]

routes = [
    ('/','GET', alive),
    ('/api','GET', functions.get),
    ('/api','POST', functions.post),
    ('/api','PUT', functions.put),
    ('/api','DELETE', functions.delete),
]