#!/bin/bash

# "py3spin" - for Python 3 with OpenAI's 'spinning up'.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=6
TFMAJOR=1
TFMINOR=12
TFPATCH=0
CONDAENVNAME="py${PYMAJOR}spin"
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

git clone https://github.com/gnperdue/spinningup.git
cd spinningup
git checkout 8b92b8a
pip install -e .
cd ..
rm -rf spinningup

DAT=`date +%s`
mkdir -p ${HOME}/Software/${CONDAENVNAME}/${DAT}
pushd ${HOME}/Software/${CONDAENVNAME}/${DAT} >& /dev/null
git clone https://github.com/gnperdue/gym-oscillator.git
pushd gym-oscillator >& /dev/null
pip install -e .
popd >& /dev/null
popd >& /dev/null

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

echo -e "\a"
