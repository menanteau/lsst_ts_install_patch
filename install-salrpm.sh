#!/bin/env bash
# This is the recipe to install SAL/OpenSplice from rpms
# Note: This rpms needs toe installed in the system
yum -y install git gcc-c++ make patch wget

# to remove
# yum list installed | grep lsst-ts | awk '{printf "sudo yum -y remove %s\n",$1}'

# Remove first
rpmlist=`yum list installed | grep @lsst-ts  | awk '{print $1}'`
echo "Removing: $rpmlist"
yum -y remove $rpmlist

# Add the lsst-ts repo to /etc
cp -pv lsst-ts.repo /etc/yum.repos.d

LSSTTS_RPM_VERSION=$LSSTTS_SAL_VERSION-$LSSTTS_XML_VERSION.el7
for csc in $CCS_IDL_LIST
 do
   echo $csc-$LSSTTS_RPM_VERSION
   yum install -y $csc-$LSSTTS_RPM_VERSION
 done

# Get the setup conf
echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux" > $INSTALL_PATH/setup_SAL.env
cat setup_SAL.env >> $INSTALL_PATH/setup_SAL.env
