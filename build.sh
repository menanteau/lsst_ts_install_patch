export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.0.0
export LSSTTS_SALOBJ_VERSION=5.0.0
export LSSTTS_XML_VERSION=4.4.1
export LSSTTS_IDL_VERSION=1.0.0
export CCS_IDL_LIST="EFD ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATTCS ATHexapod"

./install-salrpm.sh
./install-saldds.sh
#./install-salsrc.sh  -v_sal v$LSSTTS_SAL_VERSION -v_xml v$LSSTTS_XML_VERSION -p /opt/lsst/sal-home
./install-salidl.sh
./install-salobj.sh
