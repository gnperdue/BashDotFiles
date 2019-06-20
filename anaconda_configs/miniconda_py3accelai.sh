#!/bin/bash

# "py3accelai" - for Python 3 with atom.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=1
TFMINOR=13  # most recent on Conda as of 2019/june/20
TFPATCH=1
CONDAENVNAME="py${PYMAJOR}accelai"
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
pip install 'python-language-server[all]'

conda install -q -y tensorflow=${TFMAJOR}.${TFMINOR}.${TFPATCH}
conda install -q -y -c conda-forge tensorflow-probability
conda install -q -y -c conda-forge gpflow
conda install -q -y -c conda-forge xgboost
conda install -q -y -c conda-forge apscheduler
conda install -q -y scikit-image
conda install -q -y scikit-learn
conda install -q -y seaborn
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y sqlalchemy
conda install -q -y pandas-datareader
conda install -q -y pyqtgraph
conda install -q -y xlrd
conda install -q -y cython
conda install -q -y pyyaml
conda install -q -y sympy
conda install -q -y tqdm
conda install -q -y coverage # for test coverage analysis

# pip install --upgrade tensorflow-probability

pip install --no-cache-dir guildai
### just bare bones gym
# pip install --no-cache-dir gym
### if you have all the deps, see https://github.com/openai/gym
pip install --no-cache-dir 'gym[atari,box2d,classic_control]'
DAT=`date +%s`
mkdir -p ${HOME}/Software/${CONDAENVNAME}/${DAT}
pushd ${HOME}/Software/${CONDAENVNAME}/${DAT} >& /dev/null
git clone https://github.com/gnperdue/gym-oscillator.git
pushd gym-oscillator >& /dev/null
pip install -e .
popd >& /dev/null
git clone https://github.com/gnperdue/gym-bandits.git
pushd gym-bandits >& /dev/null
pip install -e .
popd >& /dev/null
popd >& /dev/null

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"
echo "  (or possibly, for newer versions of Anaconda)"
echo "\$ conda deactivate"

echo -e "\a"
