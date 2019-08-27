TS_SAL_VERSION=v3.10.0
TS_XML_VERSION=v4.1.1
INSTALL_PATH=/opt/lsst

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
mkdir -p /tmp/salbuild
./sal_install_fromSource.sh /tmp/salbuild
cd /tmp/salbuild
./sal_install_fromSource.sh  -v_sal $TS_SAL_VERSION -v_xml $TS_XML_VERSION -p $INSTALL_PATH/sal-home
rm -rf /tmp/salbuild
