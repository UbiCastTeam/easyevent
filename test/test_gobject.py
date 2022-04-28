#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright 2015, Florent Thiery
from gi.repository import GLib
import easyevent
import sys

easyevent.event.dispatcher = 'gobject'


class Listener(easyevent.User):

    def __init__(self):
        easyevent.User.__init__(self)
        self.register_event('speech')

    def evt_speech(self, event):
        print('Got speech event: %s' % event.content)
        print('Test success, quitting')
        self.unregister_event('speech')
        sys.exit(0)


class Shouter(easyevent.User):

    def __init__(self):
        easyevent.User.__init__(self)

    def shout(self, text):
        self.launch_event('speech', text)


if __name__ == '__main__':
    lst = Listener()
    sht = Shouter()
    GLib.idle_add(sht.shout, 'hello world')

    def failure():
        print('Test failed')
        import sys
        sys.exit(1)
    GLib.timeout_add_seconds(1, failure)

    loop = GLib.MainLoop()
    loop.run()
