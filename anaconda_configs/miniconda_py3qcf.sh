#!/bin/bash

# "py3qcf" - for Andy Li's quantum computing framework.

# Also python-language-server (for atom), and a few other valued packages.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}qcf"
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
pip install 'python-language-server[all]'

conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y poppler     # for qiskit circuit drawer
conda install -q -y ipywidgets  # for qiskit viz

#CFLAGS=-stdlib=libc++ pip install --no-cache-dir qiskit==0.8.1
# CFLAGS=-stdlib=libc++ pip install --no-cache-dir qiskit==0.10.5
# pip install --no-cache-dir qiskit qiskit-aqua qiskit-chemistry
# pip install --upgrade --no-cache-dir qiskit==0.10.5
pip install --upgrade --no-cache-dir qiskit
pip install --no-cache-dir cirq==0.5.0
pip install --no-cache-dir pyquil==2.6.0

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
