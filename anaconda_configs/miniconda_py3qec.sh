#!/bin/bash

# "py3qec" - FNAL QEC circuit simulator

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=10
CONDAENVNAME="py${PYMAJOR}qec"
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
pip install --upgrade setuptools

conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y tqdm
conda install -q -y coverage
conda install -q -y numpy
conda install -q -y matplotlib
conda install -q -y scipy
conda install -q -y prettytable
conda install -q -y h5py
conda install -q -y tabulate

pip install --no-cache-dir qiskit
pip install --no-cache-dir qiskit-aer
pip install --no-cache-dir pylatexenc

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"
echo "  (or possibly, for newer versions of Anaconda)"
echo "\$ conda deactivate"

python pyverchecker.py

echo -e "\a"
