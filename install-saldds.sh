#!/bin/bash

set -e

# Install python dds from the OpenSplice rpms files
OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux
source /opt/lsst/setup_SAL.env
cd $OSPL_HOME/tools/python/src
python3 setup.py install
