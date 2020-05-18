#!/bin/env bash

set -e

# Install ts_salobj
PRODUCT_DIR=$INSTALL_PATH/ts_salobj
INSTALL_DIR=$INSTALL_PATH
rm -rf $PRODUCT_DIR
mkdir -p $PRODUCT_DIR
cd $INSTALL_DIR
git clone $GIT_LSST_TS/ts_salobj.git
cd ts_salobj
git checkout v$LSSTTS_SALOBJ_VERSION
pip install -e .

# Setup for salobj (i.e. PYTHONPATH)
cat $INSTALL_PATH/setup_salidl.env > $INSTALL_PATH/setup_salobj.env
echo "export TS_SALOBJ_DIR=$INSTALL_PATH/ts_salobj" >> $INSTALL_PATH/setup_salobj.env
echo "export PYTHONPATH=$INSTALL_PATH/ts_salobj/python:\${PYTHONPATH}" >> $INSTALL_PATH/setup_salobj.env
echo "--------------------------------------------"
echo "  Created: $INSTALL_PATH/setup_salobj.env"
echo "--------------------------------------------"
