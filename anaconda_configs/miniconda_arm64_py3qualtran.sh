#!/bin/bash

# "py3qualtran" - Some data science stuff and Qualtran.

ARCH=`uname`
CHIP=`arch`
echo `date`
CONDAENVNAMEEXT="qualtran"

PYMAJOR=3
PYMINOR=13
CONDAENVNAME="py${PYMAJOR}${CONDAENVNAMEEXT}"
PYVER="${PYMAJOR}.${PYMINOR}"
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda${PYMAJOR}-latest-MacOSX-${CHIP}.sh
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

conda install -q -y ipython notebook
conda install -q -y scipy numpy matplotlib pandas scikit-learn
conda install -q -y tqdm coverage

REQNAME="requirements_${CONDAENVNAME}.txt"
rm -vf $REQNAME
cat <<EOT >> $REQNAME
qualtran
opt_einsum
EOT
pip install -r $REQNAME
  
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
