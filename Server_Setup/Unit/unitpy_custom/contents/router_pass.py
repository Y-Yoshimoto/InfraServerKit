#!/usr/bin/env python
# -*- coding: utf-8 -*-
import router_func as rfunc

routes = [
    ('/', rfunc.get),
    ('/sendjson', rfunc.sendjson),
    ('/checkdata', rfunc.checkdata),
]
