#!/usr/bin/make -f

all: build

build:
	python setup.py build

install: build
	sudo python setup.py install

uninstall:
	sudo rm -vrf /usr/lib/python2.5/site-packages/easyevent
	sudo rm -v /usr/lib/python2.5/site-packages/easyevent*.egg-info

clean:
	rm -rf build
	rm -f build-stamp
	find . -name "*.pyc" -o -name "*~" | xargs -r rm

builddeb:
	dpkg-buildpackage -rfakeroot
