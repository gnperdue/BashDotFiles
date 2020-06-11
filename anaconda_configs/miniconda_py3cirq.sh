#!/bin/bash

# "py3cirq" - for Python 3 with Cirq.

# python-language-server (for atom), other valued packages.
# Note, this env has issues with TensorBoard (should use a bare TF only
# env for TB)? - maybe fixed by now...

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}cirq"
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

pip install tensorflow==2.1.0
pip install tensorflow-quantum
pip install cirq
pip install notebook
pip install ipython
pip install scikit-learn
pip install scikit-image


echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

python pyverchecker.py

echo -e "\a"
