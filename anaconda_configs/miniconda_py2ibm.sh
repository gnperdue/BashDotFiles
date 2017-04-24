#!/bin/bash

CONDAENVNAME="py2ibm"
CONDAINSTALL=Miniconda2-4.3.14-Linux-ppc64le.sh
MINIDIR="miniconda2"

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

# "bleeding edge"
pip install numpy
pip install picklable-itertools
pip install progressbar2
pip install pyyaml
pip install toolz
pip install scipy
pip install pandas
pip install matplotlib
pip install scikit-learn
pip install scikit-image
pip install h5py
pip install --upgrade https://github.com/Theano/Theano/archive/master.zip
pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
pip install git+git://github.com/mila-udem/fuel.git@0.2.0

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
