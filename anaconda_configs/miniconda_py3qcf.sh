#!/bin/bash

# "py3qcf" - for Andy Li's quantum computing framework.

# Also python-language-server (for atom), other valued packages.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
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
pip install 'python-language-server[all]'

conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y pyqtgraph
conda install -q -y xlrd
conda install -q -y cython
conda install -q -y pyyaml
conda install -q -y sympy
conda install -q -y poppler     # for qiskit circuit drawer
conda install -q -y ipywidgets  # for qiskit viz

pip install --no-cache-dir qiskit qiskit-terra qiskit-aqua qiskit-aqua-chemistry
pip install --no-cache-dir openfermion cirq openfermioncirq
pip install --no-cache-dir pyquil

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"