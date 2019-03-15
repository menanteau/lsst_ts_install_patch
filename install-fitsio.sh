wget https://github.com/menanteau/fitsio/archive/DMHSv0.1.tar.gz -O fitsio-DMHSv0.1.tar.gz 
tar xfz fitsio-DMHSv0.1.tar.gz
cd fitsio-DMHSv0.1
python3 setup.py install --prefix=/usr

#python setup.py install --prefix=/opt/rh/rh-python36/root/usr/
#    rm -rf build && \
#    python3.6 setup.py install --prefix=/usr
