#!/bin/bash

# "py3qiskit" - for Python 3 with Qiskit.

# Torch, python-language-server (for atom), other valued packages.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=1
TFMINOR=12
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}qiskit"
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

pip install --upgrade pip
pip install 'python-language-server[all]'

conda install -q -y pytorch torchvision -c pytorch
conda install -q -y -c conda-forge xgboost
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y ipython=6.5.0
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y pyqtgraph
conda install -q -y xlrd
conda install -q -y cython
conda install -q -y pyyaml
conda install -q -y sympy

pip install qiskit qiskit-aqua qiskit-aqua-chemistry

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
