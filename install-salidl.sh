#!/bin/env bash

set -e

INSTALL_PATH=/opt/lsst
REPOS_TMP=/tmp/repos
GIT_LSST_TS="https://github.com/lsst-ts"

# Install ts_idl
PRODUCT_DIR=$INSTALL_PATH/ts_idl
INSTALL_DIR=$INSTALL_PATH
rm -rf $PRODUCT_DIR
mkdir -p $PRODUCT_DIR
cd $INSTALL_DIR
git clone https://github.com/lsst-ts/ts_idl.git
cd ts_idl
git checkout v$LSSTTS_IDL_VERSION

# Build and install the idl -- we'll do this outside
# ./install_salsrc.sh  -v_sal v$LSSTTS_SAL_VERSION -v_xml v$LSSTTS_XML_VERSION -p $INSTALL_PATH/sal-home

# Copy the idl files from the rpm installed location
cp -pv /opt/lsst/ts_sal/idl/sal_revCoded_*.idl $PRODUCT_DIR/idl

echo "source /opt/lsst/setup_SAL.env" > $INSTALL_PATH/setup_salidl.env
echo "export TS_IDL_DIR=$INSTALL_PATH/ts_idl" >> $INSTALL_PATH/setup_salidl.env
echo "export PYTHONPATH=$INSTALL_PATH/ts_idl/python:\${PYTHONPATH}" >> $INSTALL_PATH/setup_salidl.env
echo "--------------------------------------------"
echo "  Created: $INSTALL_PATH/setup_salidl.env"
echo "--------------------------------------------"
