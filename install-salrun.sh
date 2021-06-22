#!/bin/env bash
# This is the recipe to install SAL/OpenSplice from rpms

set -e

# yum rpm extras
yum -y install git gcc-c++ make patch wget

# Add the lsst-ts repo to /etc and install the OSPL rpm
cp -pv lsst-ts.repo /etc/yum.repos.d

# Create the lsst-ts-nexus-private.repo using USER/PASS stored and environmental vars.
envsubst < lsst-ts-nexus-private-template.repo > /etc/yum.repos.d/lsst-ts-nexus-private.repo

# Remove rpms first
rpmlist=`yum list installed | grep @lsst-ts  | awk '{print $1}'`
echo "Removing: $rpmlist"
yum -y remove $rpmlist

# Remove OpenSplice before installation
yum -y remove OpenSpliceDDS
yum -y install OpenSpliceDDS-$OSPL_RPM_VERSION
export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux

# Remove the private repo information
rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

## Get the setup conf
echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux" > $INSTALL_PATH/setup_SAL.env
echo "export OSPL_URI=file://${INSTALL_PATH}/ts_ddsconfig/config/ospl-shmem.xml" >> $INSTALL_PATH/setup_SAL.env
cat setup_SAL.env >> $INSTALL_PATH/setup_SAL.env

# Install miniconda in /opt, for Py37 and beyond
echo "Installing miniconda3 on: ${MINICONDA_PATH}"
# Remove previous miniconda installation
rm -rf $MINICONDA_PATH
mkdir -p $MINICONDA_PATH
cd $MINOCONDA_PATH
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA_PATH -u

# Start the env and add channels
source $MINICONDA_PATH/bin/activate
conda config --add channels conda-forge
# Install python dds using conda
conda install -y astropy=4.1
conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-dds==$LSSTTS_DDS_VERSION
echo "------------------------------------------"
echo "  Installed ts_idl: ${LSSTTS_DDS_VERSION} "
echo "------------------------------------------"
