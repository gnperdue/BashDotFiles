#!/bin/bash

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}qutip"
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
pip install  --no-cache-dir 'python-language-server[all]'

conda install -q -y -c conda-forge qutip
conda install -q -y numpy
conda install -q -y scipy
conda install -q -y cython
conda install -q -y matplotlib
conda install -q -y pytest
conda install -q -y pytest-cov
conda install -q -y coverage
conda install -q -y jupyter
conda install -q -y notebook
conda install -q -y ipython
conda install -q -y tqdm
conda install -q -y -c conda-forge imagemagick

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
