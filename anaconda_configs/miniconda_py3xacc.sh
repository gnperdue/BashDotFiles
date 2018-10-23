#!/bin/bash

# "py3xacc" - for Python 3 with xacc, pyquil, cirq, TF, ML (no PyTorch).
# Note, this env has issues with TensorBoard (should use a bare TF only
# env for TB).

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=1
TFMINOR=11
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}xacc"
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

conda install -q -y -c conda-forge xgboost
conda install -q -y -c rigetti pyquil
conda install -q -y tensorflow=${TFMAJOR}.${TFMINOR}.${TFPATCH}
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y sympy
conda install -q -y cython

pip install --no-cache-dir dwave-ocean-sdk
pip install --no-cache-dir cirq

python -m pip install --user xacc
python -m pip install --user xacc-rigetti
python -m pip install --user xacc-dwave
python -m pip install --user xacc-vqe
python -m pip install --user tnqvm

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
