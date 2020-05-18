#!/bin/env bash
set -e

PRODUCT_DIR=$INSTALL_PATH/ts_idl

# Copy the idl files from the rpm installed location
echo "---- Copying 'sal_revCoded_*.idl' from rpms: ----------------"
cp -pv $INSTALL_PATH/ts_sal/idl/sal_revCoded_*.idl $PRODUCT_DIR/idl
echo "---- Copy done -------------------------------"
