#!/bin/env bash
set -e

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
