#!/usr/bin/env python
# -*- coding: utf-8 -*-
import router_func as rfunc
import Postcode_func as postcode

routes = [
    ('/', rfunc.get),
    ('/sendjson', rfunc.sendjson),
    ('/checkdata', rfunc.checkdata),
    ('/inquirypostcode', postcode.InquiryPostcode),
]
