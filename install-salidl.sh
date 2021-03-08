#!/bin/env bash

set -e

# This will install ts-idl and also it will
# install all of the sal_revCoded_*.idl files in $MINICONDA_PATH/lib/python3.7/idl
source ${MINICONDA_PATH}/bin/activate
conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-idl=${LSSTTS_IDL_CONDA_VERSION}
echo "------------------------------------------"
echo "  Installed ts_idl: ${LSSTTS_IDL_CONDA_VERSION}"
echo "------------------------------------------"
