#!/bin/bash

cd "`dirname $0`"
export PYTHONHOME=../python
../python/bin/python change_sysproxy.py
