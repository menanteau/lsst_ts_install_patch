# Install miniconda in /opt

mkdir -p $MINICONDA_PATH
cd $MINOCONDA_PATH
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA_PATH -u

# Start the env and add channels
source $MINICONDA_PATH/bin/activate
conda config --add channels conda-forge

# Pre-reqs for salobj/dds
conda install -y pyyaml setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12 boto3==1.11.14 moto=1.3.14

# Pre-reqs for the HeaderService
conda install -y fitsio==1.0.4 astropy=4.0.1 ipython pyyaml

