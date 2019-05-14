# This is the recipe to install SAL/OpenSplice from rpms

# Add the lsst-ts repo
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/lsst-ts.repo
mv -v lsst-ts.repo /etc/yum.repos.d

# These are the ones we've needed for now
yum -y install OpenSpliceDDS-6.9.0
yum -y install ATHeaderService-3.9.2
yum -y install ATCamera-3.9.2
yum -y install ATArchiver-3.9.2
yum -y install EFD-3.9.2
yum -y install Scheduler-3.9.2
yum -y install ATPtg-3.9.2
yum -y install ATMCS-3.9.2
yum -y install ATSpectrograph-3.9.2
yum -y install ATTCS-3.9.2
# Add more CSC if needed

# Get the setup conf
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/setup_SAL.env -O /opt/lsst/setup_SAL.env
