#!/bin/bash

# "py2dwv" - for Python 2 with D-wave, atom.

# TF 1.11, python-language-server (for atom), other valued packages.
# Note, this env has issues with TensorBoard (should use a bare TF only
# env for TB).

# also, go to dwave pack and `python install.py`
# also, use `easy_install` on `orang` egg (available elsewhere)

ARCH=`uname`
echo `date`

PYMAJOR=2
PYMINOR=7
TFMAJOR=1
TFMINOR=11
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}dwv"
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

pip install --upgrade pip
pip install 'python-language-server[all]'

conda install -q -y -c conda-forge xgboost
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
conda install -q -y bokeh
conda install -q -y networkx

pip install --no-cache-dir --ignore-installed --upgrade $TF_PYTHON_URL
pip install --no-cache-dir h5py
pip install --no-cache-dir dwave-ocean-sdk
pip install --no-cache-dir arff  # for some D-wave example notebooks

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
