#!/bin/bash

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
CONDAENVNAME="py${PYMAJOR}util"
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

# conda install -q -y flake8
# conda install -q -y jedi
# conda install -q -y ipython
# conda install -q -y jupyter
# conda install -q -y sqlalchemy

pip --no-cache-dir --disable-pip-version-check install --upgrade pip
pip --no-cache-dir --disable-pip-version-check install --upgrade setuptools 
pip --no-cache-dir install numpy wheel zmq six pyyaml cython
pip --no-cache-dir install psutil humanize h5py tqdm
pip --no-cache-dir install matplotlib pandas scikit-image scikit-learn Pillow
pip --no-cache-dir install flake8 jedi ipython jupyter sqlalchemy
pip --no-cache-dir install csvkit

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
