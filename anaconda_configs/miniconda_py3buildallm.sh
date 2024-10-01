#!/bin/bash

CONDAENVNAMEEXT="buildallm"
ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=12
CONDAENVNAME="py${PYMAJOR}${CONDAENVNAMEEXT}"
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

REQNAME="requirements_${CONDAENVNAME}.txt"
rm -vf $REQNAME
cat <<EOT >> $REQNAME
torch >= 2.0.1        # all
jupyterlab >= 4.0     # all
tiktoken >= 0.5.1     # ch02; ch04; ch05
matplotlib >= 3.7.1   # ch04; ch05
tensorflow >= 2.15.0  # ch05
tqdm >= 4.66.1        # ch05; ch07
numpy >= 1.25, < 2.0  # dependency of several other libraries like torch and pandas
pandas >= 2.2.1       # ch06
psutil >= 5.9.5       # ch07; already installed automatically as dependency of torch
EOT
pip install -r $REQNAME

pip install --upgrade coverage


echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"
echo "  (or possibly, for newer versions of Anaconda)"
echo "\$ conda deactivate"

#python pyverchecker.py

echo -e "\a"
