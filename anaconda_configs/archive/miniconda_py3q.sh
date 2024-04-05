#!/bin/bash

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}q"
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

# cirq and deps
pip install tensorflow==2.1.0
pip install tensorflow-quantum
pip install cirq
pip install notebook
pip install ipython
pip install scikit-learn
pip install scikit-image

# qiskit and deps
pip install qiskit
pip install matplotlib
pip install ipywidgets
pip install seaborn
pip install pygments
pip install pyyaml

# qutip and deps, maybe (also did `brew install imagemagick` -- quite a lot of
# stuff comes down!)
# may need openmp...
pip install nose
pip install pytest
pip install pytest-cov
pip install coverage
pip install qutip
#conda install -q -y -c conda-forge imagemagick  # sketchy output...

pip install sympy

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
