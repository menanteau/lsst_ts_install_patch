TS_SAL_VERSION=v3.10.0
TS_XML_VERSION=v4.1.1
INSTALL_PATH=/opt/lsst
REPOS_TMP=/tmp/repos

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
mkdir -p /tmp/salbuild
./sal_install_fromSource.sh /tmp/salbuild
cd /tmp/salbuild
./sal_install_fromSource.sh  -v_sal $TS_SAL_VERSION -v_xml $TS_XML_VERSION -p $INSTALL_PATH/sal-home
rm -rf /tmp/salbuild

TS_SALOBJ_VERSION=v4.1.0
TS_IDL_VERSION=v0.2.0
GIT_LSST_TS="https://github.com/lsst-ts"

# For salobj suport
pip3 install setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12

# Install dds from the tarball on the OpenSplice rpms
mkdir -p $REPOS_TMP/dds
cd $REPOS_TMP/dds
tar zxvf /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/tools/python-support.tgz 
cd $REPOS_TMP/dds/python/src
source /opt/lsst/setup_SAL.env
python3 setup.py install

# Install ts_salobj
PRODUCT=ts_salobj
VERSION=$TS_SALOBJ_VERSION
PRODUCT_DIR=$INSTALL_PATH/$PRODUCT
INSTALL_DIR=$INSTALL_PATH
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
git clone $GIT_LSST_TS/$PRODUCT.git
cd $PRODUCT
git checkout $VERSION
pip3 install -e .

# Install ts_idl
PRODUCT=ts_idl
VERSION=$TS_IDL_VERSION
PRODUCT_DIR=$INSTALL_PATH/$PRODUCT
INSTALL_DIR=$INSTALL_PATH
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
git clone $GIT_LSST_TS/$PRODUCT.git
cd $PRODUCT
git checkout $VERSION

# Add extra idl files from the build
cp -pv $INSTALL_PATH/sal-home/ts_sal/test/idl-templates/validated/sal/sal_revCoded_*.idl $PRODUCT_DIR/idl

# Setup for salobj (i.e. PYTHONPATH)
echo "source $INSTALL_PATH/setup_SAL.env" > $INSTALL_PATH/setup_salobj.env
echo "export PYTHONPATH=\${PYTHONPATH}:$INSTALL_PATH/ts_idl/python" >> $INSTALL_PATH/setup_salobj.env
