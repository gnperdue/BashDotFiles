#!/bin/bash

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
CONDAENVNAME="py${PYMAJOR}bio"
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
conda create -q -y -n $CONDAENVNAME biopython biopython=1.70 python=$PYVER
. activate $CONDAENVNAME

conda config --add channels bioconda
conda config --add channels conda-forge
conda install -q -y scipy
conda install -q -y matplotlib
conda install -q -y jupyter-notebook
conda install -q -y pip
conda install -q -y pandas
conda install -q -y cython
conda install -q -y numba
conda install -q -y scikit-learn
conda install -q -y seaborn
conda install -q -y pysam
conda install -q -y pyvcf
conda install -q -y simuPOP
conda install -q -y dendropy
conda install -q -y rpy2

conda install -q -y r-essentials
conda install -q -y r-gridextra

#pip install --upgrade pip
#pip install --upgrade setuptools
#pip install --no-cache-dir typing_extensions   # Py 3.7 feature
pip install  --no-cache-dir 'python-language-server[all]'

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
