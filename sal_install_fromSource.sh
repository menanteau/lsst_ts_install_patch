#!/bin/bash

# Simple script to install SAL/OCS from scrath on a centos7 machine
# It asumes that the user has sudo power

set -e

interactive=0
# Define default version as of today
SAL_VERSION=v3.10.0
XML_VERSION=v3.10.0
SAL_PATH=/opt/sal-home
while [ "$1" != "" ]; do
    case $1 in
        -v_sal | --version )        shift
                                SAL_VERSION=$1
                                ;;
        -v_xml | --version )        shift
                                XML_VERSION=$1
                                ;;
        -p | --path )           shift
                                SAL_PATH=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           echo "sal_install_fromSource.sh [-v_sal version] [-v_xml version] [-p path] [-i]] | [-h]]"
                                exit
                                ;;
        * )                     echo "sal_install_fromSource.sh [-v_sal version] [-v_xml version] [-p path] [-i]] | [-h]]"
                                exit 1
    esac
    shift
done

if [ $interactive == 1 ]; then
    echo "-----------------------------------------------------------------"
    echo "Hello, "$USER".  This script try to install the SAL/OCS software."
    echo "-----------------------------------------------------------------"
    # 1 - SAL_Version
    read -p "Please enter the ts_sal version [$SAL_VERSION]: " SAL_VERSION
    SAL_VERSION="${SAL_VERSION:-$SAL_VERSION_DEFAULT}"
    # 2 - XML_Version
    read -p "Please enter the ts_xml version [$XML_VERSION]: " XML_VERSION
    XML_VERSION="${XML_VERSION:-$XML_VERSION_DEFAULT}"
    # 3 -Install dir
    SAL_PATH_DEFAULT=$HOME/SAL-$SAL_VERSION
    read -p "Please enter the location where you will like to install it [$SAL_PATH_DEFAULT]: " SAL_PATH
    SAL_PATH="${SAL_PATH:-$SAL_PATH_DEFAULT}"
fi

# 1 - Set the git paths based on versions
GIT_URL=https://github.com/lsst-ts

# 2 - Get the tarball and make the directory
# And create the soft links for SAL_HOME and SAL_WORK_DIR
# In this case SAL_PATH == LSST_SDK_INSTALL
mkdir -p $SAL_PATH
cd $SAL_PATH

echo "Cloning ts_sal:"
echo "     git clone $GIT_URL/ts_sal.git -b $SAL_VERSION"
git clone $GIT_URL/ts_sal.git -b $SAL_VERSION

echo "Cloning ts_xml"
echo "     git clone $GIT_URL/ts_xml.git -b $XML_VERSION"
git clone $GIT_URL/ts_xml.git -b $XML_VERSION

# 3 - Make the soft links for ts_sal/lsstsal and ts_sal/test
echo "Making soft links for  $SAL_PATH/lsstsal"
ln -s ts_sal/lsstsal .
echo "Making soft links for  $SAL_PATH/test"
ln -s ts_sal/test .

# 4 - Update the setup.env to reflect the install location
echo "Updating setup.env"
cp -p $SAL_PATH/ts_sal/setup.env $SAL_PATH/ts_sal/setup.env.orig
echo "export LSST_SDK_INSTALL=$SAL_PATH" >  $SAL_PATH/ts_sal/setup.env
# Use the rpm location for V6.9 and above
echo "export OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux" >> $SAL_PATH/ts_sal/setup.env
echo "export PYTHON_BUILD_VERSION=3.6m" >> $SAL_PATH/ts_sal/setup.env
echo "export PYTHON_BUILD_LOCATION=/usr" >> $SAL_PATH/ts_sal/setup.env
cat $SAL_PATH/ts_sal/setup.env.orig >> $SAL_PATH/ts_sal/setup.env

# SAL/OCS specific commands
cat << EOF > $SAL_PATH/setup_SAL.env
export LSST_SDK_INSTALL=$SAL_PATH
export OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
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

# go to the place where we will make the build
cd $SAL_WORK_DIR

# Edit CSC as required
for device in EFD ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATTCS
do
    echo "----------------------------------------"
    echo "  Running salgenerator for $device      "
    echo "----------------------------------------"
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

# # Make the tarball -- optional
# dname=`dirname $SAL_PATH`
# bname=`basename $SAL_PATH`
# echo "Making tarball:"
# echo "  cd $dname"
# echo "  tar cf $bname-$SAL_VERSION.tar $bname"
# cd $dname
# tar cf $bname-$SAL_VERSION.tar $bname
# echo "Tarball ready at: $PWD/$bname-$SAL_VERSION.tar"

echo "To start: "
echo "   source $SAL_PATH/setup_SAL.env"


