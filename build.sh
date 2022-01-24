#!/bin/env bash
set -e

export OSPL_VERSION=6.10.4
export OSPL_RPM_VERSION=6.10.4-6.el7
export LSSTTS_DDS_VERSION=6.10.4
export LSSTTS_SAL_VERSION=6.1.0
export LSSTTS_XML_VERSION=10.2.0
export LSSTTS_SALOBJ_VERSION=6.9.0
export LSSTTS_IDL_VERSION=3.7.0
export LSSTTS_DDSCONFIG_VERSION=0.9.0
export LSSTTS_IDL_CONDA_VERSION=${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}_${LSSTTS_SAL_VERSION}
export HEADERSERVICE_VERSION=2.9.4
export MINICONDA_PATH=/opt/miniconda3
export INSTALL_PATH=/opt/lsst
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}

./install-salrun.sh
./install-conda-base.sh
./install-salddsconfig.sh
./install-salidl.sh
./install-salobj.sh
./install-headerservice.sh
