#!/bin/bash

set -e
set -x

if test -n "$PY"; then
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt-get update
  sudo apt-get install -y --allow-unauthenticated python$PY-dev

  if test "$PY" = "2.5"; then
    wget https://pypi.python.org/packages/source/s/simplejson/simplejson-3.6.3.tar.gz
    tar -xvzf simplejson-3.6.3.tar.gz
    cd simplejson-3.6.3
    sudo python$PY setup.py install
  fi
fi
