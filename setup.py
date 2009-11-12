#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, imp
from distutils.core import setup

easyevent = imp.load_source("version", "easyevent/version.py")

setup(
    name="easyevent",
    version=easyevent.VERSION,
    description="Very simple and easy-to-use python module for event-driven programming.",
    author="Damien Boucard",
    author_email="damien.boucard@ubicast.eu",
    url="http://launchpad.net/easyevent",
    license="Gnu/LGPLv2",
    packages = ['easyevent'],
)
