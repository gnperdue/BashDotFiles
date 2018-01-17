#!/bin/bash

# PyTorch

ARCH=`uname`
echo `date`

CONDAENVNAME="py3trch"
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

# Cannot currently get PyTorch 0.4.0 from `-c pytorch` -> MKL version
# conflict that seems irreparable for now...
# conda install -q -y -c anaconda mkl=2018.0.1
conda install -q -y -c soumith pytorch torchvision
conda install -q -y -c conda-forge scikit-image
conda install -q -y -c conda-forge scikit-learn
conda install -q -y flake8
conda install -q -y jedi
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

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
