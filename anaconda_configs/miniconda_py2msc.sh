#!/bin/bash

# TensorFlow package for music generation

ARCH=`uname`
echo `date`

CONDAENVNAME="py2msc"
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda2-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda2"
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
conda create -q -y -n $CONDAENVNAME python=2.7
. activate $CONDAENVNAME

conda install -q -y -c conda-forge scikit-image
conda install -q -y -c conda-forge scikit-learn
conda install -q -y flake8
conda install -q -y jedi
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y tqdm
conda install -q -y -c conda-forge msgpack-python

export TF_PYTHON_URL=https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.3.0-py2-none-any.whl
pip install --ignore-installed --upgrade $TF_PYTHON_URL
pip install keras
pip install h5py

# install Python-MIDI
pushd /tmp >& /dev/null
git clone https://github.com/vishnubob/python-midi.git
pushd python-midi >& /dev/null
python setup.py install
popd >& /dev/null
popd >& /dev/null

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
