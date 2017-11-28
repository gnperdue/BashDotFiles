#!/bin/bash

ARCH=`uname`

CONDAENVNAME="py2bm"
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

pip install -r reqs/bm_requirements.txt

pushd /tmp >& /dev/null
git clone https://github.com/jakevdp/JSAnimation.git
pushd JSAnimation >& /dev/null
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
