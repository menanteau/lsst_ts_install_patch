#!/bin/env bash

set -e

# Install ts_salobj
# This will install all of salobj
source ${MINICONDA_PATH}/bin/activate
conda install -c lsstts python=3.7 ts-salobj=${LSSTTS_SALOBJ_VERSION}

echo "# Load up HeaderService Environment" > /opt/lsst/setup_salobj.env
echo "source /opt/lsst/setup_SAL.env" >> /opt/lsst/setup_salobj.env
echo "source ${MINICONDA}/bin/activate" >> /opt/lsst/setup_salobj.env

echo "-----------------------------------------------"
echo "  Installed ts_salobj: ${LSSTTS_SALOBJ_VERSION}"
echo "-----------------------------------------------"
