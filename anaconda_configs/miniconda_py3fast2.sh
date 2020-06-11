#!/bin/bash

# Python 3.7 - PyTorch with python-language-server & fastai v2

ARCH=`uname`
echo `date`

CONDAENVNAME="py3fast2"
PYVER=3.7
CONDAINSTALL=""
MINIDIR=""

if [[ $ARCH == "Darwin" ]]; then
  CONDAINSTALL=Miniconda3-latest-MacOSX-x86_64.sh
  MINIDIR="miniconda3"
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

pip install 'python-language-server[all]'
pip install typing_extensions   # Py 3.7 feature

# from https://github.com/fastai/fastbook/blob/master/requirements.txt
# as of https://github.com/fastai/fastbook/commit/6eaae1338c1b7207a14f5c379f3dc240333685d7
pip install 'fastai2>=0.0.11'
pip install graphviz
pip install ipywidgets
pip install matplotlib
pip install 'nbdev>=0.2.12'
pip install pandas
pip install scikit-learn
pip install azure-cognitiveservices-search-imagesearch
pip install sentencepiece

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
