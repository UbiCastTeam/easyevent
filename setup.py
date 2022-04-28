#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools import setup

with open('easyevent/version.py') as fo:
    content = fo.read().strip()
    version = content.split('=')[-1].strip(' \'"')

setup(
    name='easyevent',
    version=version,
    description='Very simple and easy-to-use python module for event-driven programming.',
    author='UbiCast',
    author_email='support@ubicast.eu',
    url='https://github.com/UbiCastTeam/easyevent',
    license='Gnu/LGPLv2',
    packages=['easyevent'],
)
