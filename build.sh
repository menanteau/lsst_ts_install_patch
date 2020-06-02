#!/bin/env bash
set -e

export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.1.1
export LSSTTS_SALOBJ_VERSION=5.10.0
export LSSTTS_XML_VERSION=5.1.0
export LSSTTS_IDL_VERSION=1.2.0
#export CCS_IDL_LIST="ATHeaderService ATAOS ATCamera ATArchiver ATPtg MTPtg ATMCS ATSpectrograph Hexapod ATHexapod ATDome DIMM CCArchiver CCCamera CCHeaderService"
export MINICONDA_PATH=/opt/miniconda3
export INSTALL_PATH=/opt/lsst
export HEADERSERVICE_VERSION=2.2.0

./install-salrun.sh
./install-salidl.sh
./install-salobj.sh
./install-headerserice.sh
