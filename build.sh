#!/bin/env bash
set -e

export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.1.1
export LSSTTS_SALOBJ_VERSION=5.10.0
export LSSTTS_XML_VERSION=5.1.0
export LSSTTS_IDL_VERSION=1.2.0
export CCS_IDL_LIST="ATHeaderService ATAOS ATCamera ATArchiver ATPtg MTPtg ATMCS ATSpectrograph Hexapod ATHexapod ATDome DIMM CCArchiver CCCamera CCHeaderService"
export MINICONDA_PATH=/opt/miniconda3
# Location variables, set here insted of individual scripts
export INSTALL_PATH=/opt/lsst
export REPOS_TMP=/tmp/repos
export GIT_LSST_TS="https://github.com/lsst-ts"

./install-salrpm.sh
./install-conda-base.sh
# This ensure we use the conda environment for the rest of the builds
source $MINICONDA_PATH/bin/activate
./install-saldds.sh
./install-salidl.sh
./install-salidlfiles.sh
./install-salobj.sh
