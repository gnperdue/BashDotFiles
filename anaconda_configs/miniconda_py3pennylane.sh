#!/bin/bash

CONDAENVNAMEEXT="pennylane"
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

conda install -q -y graphviz

pip install --upgrade pip
pip install --upgrade setuptools

REQNAME="requirements_${CONDAENVNAME}.txt"
rm -vf $REQNAME
cat <<EOT >> $REQNAME
jupyterlab >= 4.0
tqdm >= 4.66.1
coverage
pennylane
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

#python pyverchecker.py
pip freeze

echo -e "\a"
