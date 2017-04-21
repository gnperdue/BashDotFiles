#!/bin/bash

ARCH=`uname`

CONDAENVNAME="py2mnvth"
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda2-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda2"
elif [[ $ARCH == "Linux" ]]; then
  CONDAINSTALL=Miniconda2-latest-Linux-x86_64.sh
  MINIDIR="miniconda2"
else
  echo "Only configured for Mac OSX so far."
  exit 1
fi

if [[ ! -d "$HOME/$MINIDIR" ]]; then
  wget https://repo.continuum.io/miniconda/$CONDAINSTALL
  bash $CONDAINSTALL -b -p $HOME/$MINIDIR
else
  echo "Existing directory $HOME/$MINIDIR !"
fi

export PATH="$HOME/$MINIDIR/bin:$PATH"

conda info --envs
conda remove -y --name $CONDAENVNAME --all
conda create -q -y -n $CONDAENVNAME python=2.7
. activate $CONDAENVNAME

conda install -q -y flake8
conda install -q -y jedi
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql

# need fairly specific set of versions to work with Minerva code
pip install numpy==1.10.4
pip install picklable-itertools==0.1.1
pip install progressbar2==3.6.0
pip install pyyaml==3.11
pip install toolz==0.7.2
pip install scipy==0.17.0
pip install pandas==0.17.1
pip install matplotlib==1.5.1
pip install scikit-learn==0.17
pip install scikit-image==0.11.3
pip install h5py==2.5.0
pip install git+https://github.com/Theano/Theano.git@rel-0.8.0
pip install Lasagne==0.1
pip install git+git://github.com/mila-udem/fuel.git@0.2.0


echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
