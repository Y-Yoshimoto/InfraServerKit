#!/usr/bin/env python
# coding:utf-8
from fastapi import APIRouter
router = APIRouter()

#fluentd
from fluent import sender
from fluent import event
sender.setup('fluentd.test', host='fluentd', port=24224)
event.Event('follow', {
    'app': 'subapp',
    'status':   'start'
})

# Rootパス用
@router.get("/sub/")
def read_root():
    return {"Path": "sub/root"}
