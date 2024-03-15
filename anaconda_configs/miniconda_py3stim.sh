#!/bin/bash

# "py3stim" - Stim

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=10
CONDAENVNAME="py${PYMAJOR}stim"
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

# rm -vf requirements_stim.txt
# cat <<EOT >> requirements_stim.txt
# cirq==1.3
# ipython==8.1.1
# jsonschema>=4.18.0
# jupyter==1.0.0
# jupyter_server==2.12.2
# jupyter_server_terminals==0.5.1
# jupyterlab==4.0.10
# jupyterlab_server==2.25.2
# matplotlib==3.8.3
# numpy==1.26.4
# PyMatching==2.2.0
# QKeras==0.9.0
# scikit-learn==1.4.1.post1
# scipy==1.11.1
# stim==1.12.1
# tensorboard==2.15.1
# tensorflow==2.15.0
# tqdm==4.66.1
# EOT
# pip install -r requirements_stim.txt

# works
# rm -vf requirements_stim.txt
# cat <<EOT >> requirements_stim.txt
# ipython<=8.22.2
# jupyter<=1.0.0
# PyMatching<=2.2.0
# stim==1.12.1
# EOT
# pip install -r requirements_stim.txt

# works
rm -vf requirements_stim.txt
cat <<EOT >> requirements_stim.txt
ipython==8.22.2
jupyter==1.0.0
matplotlib==3.8.3
numpy==1.26.4
PyMatching==2.2.0
QKeras==0.9.0
scikit-learn==1.4.1.post1
scipy==1.12.0
sinter==1.12.1
stim==1.12.1
tensorboard==2.11.2
tensorflow==2.11.1
EOT
pip install -r requirements_stim.txt


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
