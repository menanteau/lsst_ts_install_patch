export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.1.0
export LSSTTS_SALOBJ_VERSION=5.10.0
export LSSTTS_XML_VERSION=5.0.0
export LSSTTS_IDL_VERSION=1.1.3
export CCS_IDL_LIST="ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATHexapod ATDome DIMM CCArchiver CCCamera CCHeaderService"
export MINICONDA_PATH=/opt/miniconda3

./install-salrpm.sh
./install-conda-base.sh
# This ensure we use the conda environment for the rest of the builds
source $MINICONDA_PATH/bin/activate 
./install-saldds.sh
./install-salidl.sh
./install-salobj.sh
