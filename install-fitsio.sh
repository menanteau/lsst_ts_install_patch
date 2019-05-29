#VERSION=1.0.3 -- this one does not work
VERSION=1.0.0
URL=https://github.com/esheldon/fitsio
mkdir -p /tmp/fitsio-$USER
cd /tmp/fitsio-$USER

wget $URL/archive/v$VERSION.tar.gz -O fitsio-$VERSION.tar.gz
tar xvfz fitsio-$VERSION.tar.gz
cd fitsio-$VERSION

# HOME install option
#mkdir -p $HOME/Python3/lib64/python
#export PYTHONPATH=$HOME/Python3/lib64/python:${PYTHONPATH}
#python3 setup.py install --home=$HOME/Python3

# /usr install
python3 setup.py install --prefix=/usr

# Clean up
rm -rfv /tmp/fitsio-$USER

