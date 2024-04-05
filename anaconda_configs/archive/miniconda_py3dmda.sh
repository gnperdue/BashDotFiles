#!/bin/bash

# Python 3.7 - DeepMerge Domain Aadaption

ARCH=`uname`
echo `date`

CONDAENVNAME="py3dmda"
PYVER=3.7
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda3-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda3"
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
pip install typing_extensions   # Py 3.7 feature

conda install -q -y -c pytorch -c conda-forge --file requirements/requirements_deepmergedomainadapt.txt

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
