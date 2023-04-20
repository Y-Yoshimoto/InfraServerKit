
from fluent import sender
from fluent import event
sender.setup('fluentd.test', host='fluentd', port=24224)
event.Event('follow', {
    'from': 'userA',
    'to':   'userB'
})
print("test.py")