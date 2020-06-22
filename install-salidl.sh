#!/bin/env bash

set -e

# This will install ts-idl and also it will
# install all of the sal_revCoded_*.idl files in $MINICONDA_PATH/lib/python3.7/idl
source ${MINICONDA_PATH}/bin/activate
conda install -y -c lsstts python=3.7 ts-idl=${LSSTTS_IDL_VERSION}_${LSSTTS_SAL_VERSION}_${LSSTTS_XML_VERSION}
echo "------------------------------------------"
echo "  Installed ts_idl: ${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}"
echo "------------------------------------------"
