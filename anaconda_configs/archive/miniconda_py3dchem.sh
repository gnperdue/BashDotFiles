#!/bin/bash

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
CONDAENVNAME="py${PYMAJOR}dchem"
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

conda install -q -y -c deepchem -c rdkit -c conda-forge -c omnia deepchem
## most of this comes with deepchem and getting the install to work with all
## of these items explicit is almost impossible...
# conda install -q -y scipy
# conda install -q -y matplotlib
# conda install -q -y jupyter-notebook
# conda install -q -y ipython
# conda install -q -y pip
# conda install -q -y pandas
# conda install -q -y cython
# conda install -q -y numba
# conda install -q -y scikit-learn
# conda install -q -y seaborn

pip install  --no-cache-dir 'python-language-server[all]'

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

python pyverchecker.py
conda list

echo -e "\a"
