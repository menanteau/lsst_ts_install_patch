#!/bin/env bash
# This will install the headerservice and pre-reqs

set -e
source ${MINICONDA_PATH}/bin/activate
conda install -y python=3.8 fitsio pyyaml

# We need to go old school and use a python install instead
source ${MINICONDA_PATH}/bin/activate && \
mkdir -p /tmp/repos && \
cd /tmp/repos && \
git clone https://github.com/lsst-dm/HeaderService -b ${HEADERSERVICE_VERSION} && \
cd HeaderService && \
export PYTHONPATH=$PYTHONPATH:$CONDA_PREFIX/HeaderService/python &&\
python setup.py install --prefix=$CONDA_PREFIX/HeaderService --install-lib=$CONDA_PREFIX/HeaderService/python --install-data $CONDA_PREFIX/HeaderService
cd ../
rm -rf /tmp/repos

echo "------------------------------------------"
echo "  Installed headerservice: ${HEADERSERVICE_VERSION}"
echo "------------------------------------------"
