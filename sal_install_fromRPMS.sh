# This is the recipe to install SAL/OpenSplice from rpms

SAL_VERSION=3.10.0_001
OPSL_VERSION=6.9.0

# to remove
# yum list installed | grep lsst-ts | awk '{printf "sudo yum -y remove %s\n",$1}'

# Add the lsst-ts repo
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/lsst-ts.repo
mv -v lsst-ts.repo /etc/yum.repos.d

# These are the ones we've needed for now
yum -y install OpenSpliceDDS-$OPSL_VERSION
yum -y install ATHeaderService-$SAL_VERSION
yum -y install ATCamera-$SAL_VERSION
yum -y install ATArchiver-$SAL_VERSION
yum -y install EFD-$SAL_VERSION
yum -y install Scheduler-$SAL_VERSION
yum -y install ATPtg-$SAL_VERSION
yum -y install ATMCS-$SAL_VERSION
yum -y install ATSpectrograph-$SAL_VERSION
yum -y install ATTCS-$SAL_VERSION
# Add more CSC if needed

# Get the setup conf
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/setup_SAL.env -O /opt/lsst/setup_SAL.env
