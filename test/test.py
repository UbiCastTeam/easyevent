#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright 2015, Florent Thiery 

from __future__ import print_function
import easyevent

class Listener(easyevent.User):
  def __init__(self):
    easyevent.User.__init__(self)
    self.register_event("speech")
    
  def evt_speech(self, event):
    print("Got speech event, : %s" %event.content)
    print("Test success, quitting")
    self.unregister_event("speech")
    #self.unregister_all_events()
    import sys
    sys.exit(0)
    
class Shouter(easyevent.User):
  def __init__(self):
    easyevent.User.__init__(self)
    
  def shout(self, text):
    self.launch_event('speech', text)
    
if __name__ == "__main__":
    l = Listener()
    s = Shouter()
    s.shout("hello world")
    # at that point, Listener prints "Got speech event: hello world"
    print("Event not received, test failed")
    sys.exit(1)
