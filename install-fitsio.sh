VERSION=1.0.4
URL=https://github.com/esheldon/fitsio
mkdir -p /tmp/fitsio-$USER
cd /tmp/fitsio-$USER

wget $URL/archive/v$VERSION.tar.gz -O fitsio-$VERSION.tar.gz
tar xvfz fitsio-$VERSION.tar.gz
cd fitsio-$VERSION

# HOME install option -- for testing salobj
#mkdir -p $HOME/Python3/salobj/lib/python
#export PYTHONPATH=$HOME/salobj-home/Python3/lib/python:${PYTHONPATH}
#python setup.py install --home=$HOME/salobj-home/Python3

# /usr install
python3 setup.py install --prefix=/usr

# Clean up
rm -rfv /tmp/fitsio-$USER

