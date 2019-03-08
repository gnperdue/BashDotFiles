#!/bin/bash

# "py3tf2" - TF 2.0 Preview

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=2
TFMINOR=0
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}tf${TFMAJOR}"
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
pip install --no-cache-dir 'python-language-server[all]'
pip install --no-cache-dir tensorflow==2.0.0-alpha0
pip install --no-cache-dir mlflow

conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y tqdm
conda install -q -y coverage

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
