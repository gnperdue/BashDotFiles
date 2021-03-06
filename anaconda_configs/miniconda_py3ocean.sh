#!/bin/bash

# TensorFlow 1.14.0 (most recent conda as of 2019/Sept) plus some dwave stuff

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
TFMAJOR=1
TFMINOR=14
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}ocean"
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

pip install 'python-language-server[all]'

conda install -q -y tensorflow=${TFMAJOR}.${TFMINOR}.${TFPATCH}
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y tqdm
conda install -q -y coverage

pip install dwave-ocean-sdk
pip install dwave-hybrid
pip install dwave-system
pip install dwave-system[drivers] --extra-index-url https://pypi.dwavesys.com/simple

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
