#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import router_pass as rpass

def application(environ, start_response):
    for path, method, func in rpass.routes:
        if path == environ['PATH_INFO']:
            if method == environ.get('REQUEST_METHOD'):
                return func(environ, start_response)

    return rpass.not_found(environ, start_response)
