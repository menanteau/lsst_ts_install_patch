#!/bin/env bash
# This is the recipe to install SAL/OpenSplice from rpms

set -e

# yum rpm extras
yum -y install git gcc-c++ make patch wget

# Add the lsst-ts repo to /etc and install the OSPL rpm
cp -pv lsst-ts.repo /etc/yum.repos.d
yum -y install OpenSpliceDDS-$OSPL_VERSION
export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux

# Get the setup conf
echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux" > $INSTALL_PATH/setup_SAL.env
cat setup_SAL.env >> $INSTALL_PATH/setup_SAL.env

# Install miniconda in /opt, for Py37 and beyond
echo "Installing miniconda3 on: ${MINICONDA_PATH}"
mkdir -p $MINICONDA_PATH
cd $MINOCONDA_PATH
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA_PATH -u

# Start the env and add channels
source $MINICONDA_PATH/bin/activate
conda config --add channels conda-forge
# Install python dds using conda
conda install -y -c lsstts python=3.7 ts-dds==v$LSSTTS_DDS_VERSION
