#!/bin/env bash

set -e

# Install via git clone ts_idl
PRODUCT_DIR=$INSTALL_PATH/ts_idl
INSTALL_DIR=$INSTALL_PATH
rm -rf $PRODUCT_DIR
mkdir -p $PRODUCT_DIR
cd $INSTALL_DIR
git clone $GIT_LSST_TS/ts_idl.git
cd ts_idl
git checkout v$LSSTTS_IDL_VERSION

echo "source /opt/lsst/setup_SAL.env" > $INSTALL_PATH/setup_salidl.env
echo "export TS_IDL_DIR=$INSTALL_PATH/ts_idl" >> $INSTALL_PATH/setup_salidl.env
echo "export PYTHONPATH=$INSTALL_PATH/ts_idl/python:\${PYTHONPATH}" >> $INSTALL_PATH/setup_salidl.env
echo "--------------------------------------------"
echo "  Created: $INSTALL_PATH/setup_salidl.env"
echo "--------------------------------------------"
