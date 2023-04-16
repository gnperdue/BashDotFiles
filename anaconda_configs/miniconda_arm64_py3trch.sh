#!/bin/bash

# "py3trch" - for Python 3.

ARCH=`uname`
CHIP=`arch`
echo `date`
CONDAENVNAMEEXT="trch"

PYMAJOR=3
PYMINOR=9
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

conda install -q -y ipython
conda install -q -y jupyter


conda install -y pytorch"<3" torchvision -c pytorch 
# huggingface transformers
pip install transformers
# huggingface datasets
pip install datasets
# openai's fast bpe code
pip install tiktoken
# logging
pip install wandb
pip install tqdm

# pip install 'python-language-server[all]'
# conda install -q -y ipython
# conda install -q -y jupyter
  
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
