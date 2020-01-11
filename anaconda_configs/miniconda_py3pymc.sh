#!/bin/bash

# PyMC3

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}pymc"
PYVER="${PYMAJOR}.${PYMINOR}"
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda${PYMAJOR}-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda${PYMAJOR}"
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

# conda install -q -y -c conda-forge pymc3
# conda install -q -y -c conda-forge scikit-image
# conda install -q -y -c conda-forge scikit-learn
conda install -q -y pymc3
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y flake8
conda install -q -y jedi
conda install -q -y ipython
# conda install -q -y -c conda-forge ipdb
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y pyqtgraph
conda install -q -y xlrd
# conda install -q -y cython
conda install -q -y h5py
# conda install mkl-service  # needed?

# pip install --no-cache-dir --disable-pip-version-check --ignore-installed msgpack
# conda install -q -y -c conda-forge praw
# pip install --no-cache-dir --disable-pip-version-check --ignore-installed praw

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
