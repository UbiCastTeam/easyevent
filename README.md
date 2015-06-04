# EasyEvent

## Description

EasyEvent is a basic publish/subscribe library that supports callback or gobject dispatchers.

## Usage

```
from __future__ import print_function
import easyevent

class Listener(easyevent.User):
  def __init__(self):
    easyevent.User.__init__(self)
    self.register_event("speech")
    
  def evt_speech(self, event):
    print("Got speech event: %s" %event.content)
    
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
    l.unregister_event("speech")
```
