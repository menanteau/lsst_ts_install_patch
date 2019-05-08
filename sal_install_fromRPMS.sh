# This is the recipe to install SAL/OpenSplice from rpms

# Add the lsst-ts repo
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/lsst-ts.repo
mv -v lsst-ts.repo /etc/yum.repos.d

# These are the ones we've needed for now
yum -y install ATHeaderService
yum -y install ATCamera
yum -y install ATArchiver
yum -y install EFD
yum -y install Scheduler
yum -y install ATPtg
yum -y install ATMCS
yum -y install ATSpectrograph
yum -y install ATTCS

# Add more CSC if needed

# Get the setup conf
wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/setup_SAL.env -O /opt/lsst/setup_SAL.env
