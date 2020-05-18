#!/bin/env bash
set -e

# Install miniconda in /opt
mkdir -p $MINICONDA_PATH
cd $MINOCONDA_PATH
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA_PATH -u

# Start the env and add channels
source $MINICONDA_PATH/bin/activate
conda config --add channels conda-forge

# Pre-reqs for salobj/dds (i.e. all CSCs)
conda install -y pyyaml astropy=4.0.1 setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12 boto3==1.11.14 moto=1.3.14

# Pre-reqs for the HeaderService only
conda install -y fitsio==1.0.4 ipython pyyaml
