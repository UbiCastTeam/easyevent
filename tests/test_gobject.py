from gi.repository import GLib

import easyevent


class Listener(easyevent.User):

    def __init__(self):
        super().__init__()
        self.received_events = []
        self.register_event('speech')

    def evt_speech(self, event):
        self.received_events.append(event)
        self.unregister_event('speech')


class Shouter(easyevent.User):

    def shout(self, text):
        self.launch_event('speech', text)


def test_gobject():
    easyevent.event.dispatcher = 'gobject'
    loop = GLib.MainLoop()

    lst = Listener()
    sht = Shouter()

    GLib.timeout_add(500, sht.shout, 'hello world')
    GLib.timeout_add(1000, loop.quit)
    loop.run()

    assert len(lst.received_events) == 1
    assert lst.received_events[0].content == 'hello world'
