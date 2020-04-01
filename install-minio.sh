# Make sure password are set using envirment variables
if [[ ! -v MYS3_ACCESS_KEY ]]; then
    echo "MYS3_ACCESS_KEY is not set -- please set"
    exit
elif [[ ! -v MYS3_SECRET_KEY ]]; then
    echo "MYS3_SECRET_KEY is not set -- please set"
    exit
fi
    
echo "# Will use SECRET_KEY: $MYS3_SECRET_KEY"
echo "# Will use:ACCESS_KEY: $MYS3_ACCESS_KEY"


# How to setup minio as a server,
# Largely based on:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-an-object-storage-server-using-minio-on-ubuntu-18-04

# Get the minio binary and change permissions
echo "Downloading minio"
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio

# Move into the /usr/local/bin directory where Minio’s systemd startup script expects to find it:
mv minio /usr/local/bin


# Best to avoid running the Minio server as root, create minio-user
echo "Adding user: minio-user"
useradd -r minio-user -s /sbin/nologin

# change ownership of the Minio binary to minio-user:
chown minio-user:minio-user /usr/local/bin/minio

# create a directory where Minio will store files
echo "Creating local path"
mkdir /usr/local/share/minio

# Give ownership of that directory to minio-user:
chown minio-user:minio-user /usr/local/share/minio

# Create your Minio configuration file there on /etc
echo "Creating /etc/minio"
mkdir /etc/minio

# Give ownership of that directory to minio-user too
chown minio-user:minio-user /etc/minio

# Add to /etc/default/minio
echo "Populating /etc/default/minio"
cat << EOF > /etc/default/minio
MINIO_ACCESS_KEY=${MYS3_ACCESS_KEY}
MINIO_SECRET_KEY=${MYS3_SECRET_KEY}
MINIO_VOLUMES="/usr/local/share/minio/"
MINIO_OPTS="-C /etc/minio --compat"
EOF

# Installing the Minio Systemd Startup Script
echo "Installing the Minio Systemd Startup Script"
wget https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/minio.service

# Move to systemd configuration directory, so move minio.service there:
mv minio.service /etc/systemd/system

# reload all systemd units:
systemctl daemon-reload

# enable Minio to start on boot:
echo "Enabling minio"
systemctl enable minio

# start the Minio server:
echo "Starting minio"
systemctl start minio

# Verify Minio’s status, the IP address it’s bound to, its memory usage, and more by running this command:
systemctl status minio -l

#
# Pole a hole on port 9000
# Add the followin line to: /etc/sysconfig/iptables
# 
# -A INPUT -s 141.142.238.0/24 -p tcp -m multiport --dports 9000 -m comment --comment "510 allow HederService minio-S3 access from ncsa238" -j ACCEPT
#
# Then restart
# sudo service iptables restart
#
# To stop minio
# sudo systemctl stop minio
#
# To disable minio
# sudo systemctl disable minio

