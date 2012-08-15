#!/bin/bash

cd "`dirname $0`"
export PYTHONHOME=../python
echo $1 | sudo -S ../python/bin/python change_sysproxy.py
