echo "Stopping minio"
systemctl start minio

echo "Disabling minio"
systemctl disable minio  

echo "Removing minio from /usr/local/bin"
rm -vf /usr/local/bin/minio

echo "Removing user: minio"
userdel -r minio-user

echo "Remove data directory"
rm -rfv /usr/local/share/minio

echo "Remove /etc/minio"
rm -rfv  /etc/minio

echo "Removing /etc/default/minio"
rm -vf /etc/default/minio 

echo "Removing /etc/systemd/system/minio.service"
rm -vf  /etc/systemd/system/minio.service
