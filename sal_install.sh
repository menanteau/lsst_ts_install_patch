#!/bin/bash

# Simple script to install SAL/OCS from scrath on a centos7 machine
# It asumes that the user has sudo power

set -e

interactive=0
VERSION=v3.8.41
SAL_PATH=/opt/sal-home
while [ "$1" != "" ]; do
    case $1 in
        -v | --version )        shift
                                VERSION=$1
                                ;;
        -p | --path )           shift
                                SAL_PATH=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           echo "sal_install.sh [-v version ] [-p path] [-i]] | [-h]]"
                                exit
                                ;;
        * )                     echo "sal_install.sh [-v version ] [-p path] [-i]] | [-h]]"
                                exit 1
    esac
    shift
done

if [ $interactive == 1 ]; then
    echo "-----------------------------------------------------------------"
    echo "Hello, "$USER".  This script try to install the SAL/OCS software."
    echo "-----------------------------------------------------------------"
    # 1 - Version
    VERSION_DEFAULT=v3.8.41
    read -p "Please enter the version [$VERSION_DEFAULT]: " VERSION
    VERSION="${VERSION:-$VERSION_DEFAULT}"
    # 2 -Install dir
    SAL_PATH_DEFAULT=$HOME/SAL-$VERSION
    read -p "Please enter the location where you will like to install it [$SAL_PATH_DEFAULT]: " SAL_PATH
    SAL_PATH="${SAL_PATH:-$SAL_PATH_DEFAULT}"
fi

# 1 - Set the git paths based on versions
GIT_URL=https://github.com/lsst-ts
SAL_VERSION=$VERSION
XML_VERSION=$VERSION
OSPL_VERSION=$VERSION

# 2 - Get the tarball and make the directory
# And create the soft links for SAL_HOME and SAL_WORK_DIR
# In this case SAL_PATH == LSST_SDK_INSTALL
mkdir -p $SAL_PATH
cd $SAL_PATH

git clone $GIT_URL/ts_sal.git -b $SAL_VERSION
git clone $GIT_URL/ts_xml.git -b $XML_VERSION
git clone $GIT_URL/ts_opensplice.git -b $OSPL_VERSION

# 3 - Make the soft links for ts_sal/lsstsal and ts_sal/test
echo "Making soft links for  $SAL_PATH/lsstsal"
ln -s ts_sal/lsstsal .
echo "Making soft links for  $SAL_PATH/test"
ln -s ts_sal/test .

# 4 - Update the setup.env to reflect the install location
echo "Updating setup.env"
cp -p $SAL_PATH/ts_sal/setup.env $SAL_PATH/ts_sal/setup.env.orig 
echo "export LSST_SDK_INSTALL=$SAL_PATH" >  $SAL_PATH/ts_sal/setup.env
echo "export OSPL_HOME=\$LSST_SDK_INSTALL/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux" >> $SAL_PATH/ts_sal/setup.env
echo "export PYTHON_BUILD_VERSION=3.6m" >> $SAL_PATH/ts_sal/setup.env
echo "export PYTHON_BUILD_LOCATION=/usr" >> $SAL_PATH/ts_sal/setup.env
cat $SAL_PATH/ts_sal/setup.env.orig >> $SAL_PATH/ts_sal/setup.env

# SAL/OCS specific commands
cat << EOF > $SAL_PATH/setup_SAL.env
export LSST_SDK_INSTALL=$SAL_PATH
export OSPL_HOME=\$LSST_SDK_INSTALL/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
source \$LSST_SDK_INSTALL/ts_sal/setup.env
EOF

# Source for sal generation
source $SAL_PATH/ts_sal/setup.env

# Copy the extra xml for the ocs
# Geneate the SAL interfaces
echo "Will generate SAL interfaces now...."
echo "Copying XML files to $SAL_WORK_DIR"
cp -pv $LSST_SDK_INSTALL/ts_xml/sal_interfaces/SALGenerics.xml $SAL_WORK_DIR
cp -pv $LSST_SDK_INSTALL/ts_xml/sal_interfaces/SALSubsystems.xml $SAL_WORK_DIR
cp -pv $LSST_SDK_INSTALL/ts_xml/sal_interfaces/*/*xml $SAL_WORK_DIR

cd $SAL_WORK_DIR

for device in EFD ATHeaderService ATCamera Scheduler ATArchiver ATTCS
do
    salgenerator $device validate
    salgenerator $device html
    salgenerator $device sal cpp
    salgenerator $device sal python
done

# Copy the new libs
# $SAL_WORK_DIR/lib should already be on the PYTHONPATH
echo "Making soft links for SALPY libraries"

# This one get the SALPY files
ln -s $SAL_WORK_DIR/*/*/*/*.so $SAL_WORK_DIR/lib

# Make the tarball
dname=`dirname $SAL_PATH`
bname=`basename $SAL_PATH`
echo "Making tarball:"
echo "  cd $dname"
echo "  tar cf $bname-$VERSION.tar $bname"
cd $dname
tar cf $bname-$VERSION.tar $bname
echo "Tarball ready at: $PWD/$bname-$VERSION.tar"


echo "To start: "
echo "   source $SAL_PATH/setup_SAL.env"


