#!/bin/bash

# TensorFlow 1.8 only (minerva train)

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=1
TFMINOR=8
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}mnv_trn"
PYVER="${PYMAJOR}.${PYMINOR}"
export TF_PYTHON_URL=https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-${TFMAJOR}.${TFMINOR}.${TFPATCH}-py${PYMAJOR}-none-any.whl
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

pip install --no-cache-dir --ignore-installed --upgrade $TF_PYTHON_URL
pip install --no-cache-dir h5py

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
