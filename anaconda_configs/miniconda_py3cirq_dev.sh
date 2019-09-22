#!/bin/bash

# "py3cirq_dev" - for Python 3 with Cirq, cutting edge(ish) versions.

ARCH=`uname`
echo `date`

PYMAJOR=3
PYMINOR=7
CONDAENVNAME="py${PYMAJOR}cirq_dev"
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
pip install  --no-cache-dir jupyter ipython

DAT=`date +%s`
mkdir -p ${HOME}/Software/${CONDAENVNAME}/${DAT}
pushd ${HOME}/Software/${CONDAENVNAME}/${DAT} >& /dev/null
git clone https://github.com/quantumlib/Cirq.git
pushd Cirq >& /dev/null
python -m pip install -r requirements.txt
python -m pip install -r dev_tools/conf/pip-list-dev-tools.txt
python -m pip install -r cirq/contrib/contrib-requirements.txt
python -m pip install -e .
popd >& /dev/null
popd >& /dev/null

echo "Be sure to adjust your PATH and include $HOME/$MINIDIR/bin"
echo " e.g., export PATH=$HOME/$MINIDIR/bin:\$PATH"
echo "Activate the $CONDAENVNAME environment with"
echo "\$ source activate $CONDAENVNAME"
echo "and deactivate with"
echo "\$ source deactivate"

python pyverchecker.py

echo -e "\a"
