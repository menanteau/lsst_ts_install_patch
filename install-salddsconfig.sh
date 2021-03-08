#!/bin/env bash
# This is the recipe to install SAL/OpenSplice from rpms

set -e

# Install the OSPL configuration
git clone https://github.com/lsst-ts/ts_ddsconfig --branch v${LSSTTS_DDSCONFIG_VERSION}
mv -v ts_ddsconfig $INSTALL_PATH

# Get the setup conf
echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux" > $INSTALL_PATH/setup_SAL.env
echo "export OSPL_URI=file://${INSTALL_PATH}/ts_ddsconfig/config/ospl-shmem.xml" >> $INSTALL_PATH/setup_SAL.env
cat setup_SAL.env >> $INSTALL_PATH/setup_SAL.env
