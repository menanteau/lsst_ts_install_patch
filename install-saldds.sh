#!/bin/bash

set -e

# Install python dds from the OpenSplice rpms files
source $INSTALL_PATH/setup_SAL.env
cd $OSPL_HOME/tools/python/src
python setup.py install
