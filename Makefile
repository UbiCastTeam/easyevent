#!/usr/bin/make -f

install:
	python setup.py build && sudo python setup.py install

uninstall:
	sudo rm -vrf /usr/lib/python2.5/site-packages/easyevent
	sudo rm -v /usr/lib/python2.5/site-packages/easyevent*.egg-info

clean:
	rm -vrf build
