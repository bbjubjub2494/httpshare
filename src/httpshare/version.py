# Copyright 2020 Julie Bettens


import json, pkgutil

from collections import namedtuple

version_info = namedtuple('version', 'major minor patch suffix')(
    **json.loads(pkgutil.get_data('httpshare', 'version.json'))
)

version = '%(major)d.%(minor)d.%(patch)d' % version_info._asdict()

if version_info.suffix:
    version = '%s-%s' % (version, version_info.suffix)
