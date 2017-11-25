# Copyright 2017 Julie Bettens


from collections import namedtuple

PREFIX = ''
MAJOR = 1
MINOR = 0
PATCH = 0
PATCH = 1
SUFFIX = ''

version = '{}.{}.{}'.format(MAJOR, MINOR, PATCH)

if PREFIX:
    version = '{}-{}'.format(PREFIX, version)
if SUFFIX:
    version = '{}-{}'.format(version, SUFFIX)

version_info = namedtuple('version', 'prefix major minor patch suffix')(PREFIX, MAJOR, MINOR, PATCH, SUFFIX)
