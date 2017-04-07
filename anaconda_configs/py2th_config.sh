#!/bin/bash

conda info --envs
conda remove --name py2th --all
conda create -q -y -n py2th python=2.7
. activate py2th

conda install -q -y -c conda-forge pymc3
conda install -q -y -c conda-forge scikit-image
conda install -q -y -c conda-forge scikit-learn
conda install -q -y -c conda-forge keras
conda install -q -y flake8
conda install -q -y jedi
conda install -q -y ipython
conda install -q -y jupyter
conda install -q -y pymysql
conda install -q -y pandas-datareader
conda install -q -y xlrd
