#!/bin/bash

# Python 3.6 - PyTorch with python-language-server
# Note, `swig` v3+ is required for gym. Consider `brew install swig`

ARCH=`uname`
echo `date`

CONDAENVNAME="py3mpnn"
PYVER=3.6
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda3-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda3"
else
  echo "Only configured for Mac OSX so far."
  exit 1
fi

if [[ ! -d "$HOME/$MINIDIR" ]]; then
  wget https://repo.continuum.io/miniconda/$CONDAINSTALL
  bash $CONDAINSTALL -b -p $HOME/$MINIDIR
fi

export PATH="$HOME/$MINIDIR/bin:$PATH"

conda info --envs
conda remove --yes --name $CONDAENVNAME --all
conda create -q -y -n $CONDAENVNAME python=$PYVER
. activate $CONDAENVNAME

pip install 'python-language-server[all]'

conda install -q -y pytorch torchvision -c pytorch
conda install -q -y -c conda-forge xgboost
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y h5py
conda install -q -y ujson
conda install -q -y tornado  # probably already installed at this point
conda install -q -y gevent
conda install -q -y pycurl
conda install -q -y aiohttp  # for High Performance Python examples
conda install -q -y tqdm     # for Fluent Python

conda install -q -y networkx        # for nmp_qc
conda install -q -y joblib          # for nmp_qc
conda install -q -y rdkit -c rdkit  # http://www.rdkit.org
pip install --no-cache-dir tensorboard_logger  # for nmp_qc
pip install --no-cache-dir wget            # for nmp_qc

### just bare bones gym
# pip install --no-cache-dir gym
### if you have all the deps, see https://github.com/openai/gym
pip install --no-cache-dir 'gym[all]'

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
