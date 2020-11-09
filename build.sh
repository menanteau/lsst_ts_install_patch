#!/bin/env bash
set -e

export OSPL_VERSION=6.10.4
export OSPL_RPM_VERSION=6.10.4-6.el7
export LSSTTS_DDS_VERSION=6.10.4_6
export LSSTTS_SAL_VERSION=5.0.1
export LSSTTS_XML_VERSION=6.2.1
export LSSTTS_SALOBJ_VERSION=6.0.3
export LSSTTS_IDL_VERSION=2.1.0
export LSSTTS_DDSCONFIG_VERSION=v0.1.0
export LSSTTS_IDL_CONDA_VERSION=${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}_${LSSTTS_SAL_VERSION}
export HEADERSERVICE_VERSION=2.5.1
export MINICONDA_PATH=/opt/miniconda3
export INSTALL_PATH=/opt/lsst
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}

./install-salrun.sh
./install-salidl.sh
./install-salobj.sh
./install-headerservice.sh
