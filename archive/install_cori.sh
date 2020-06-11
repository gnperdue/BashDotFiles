#!/usr/bin/env bash

# Note, on Cori, we want to use the default profile as it has lots of
# system-specific stuff on it. Note, we must edit the NERSC .bash_profile
# file by hand to include the local file - we want to edit bash_profile.ext.

# Check to see if the bash profiles already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

if [ -L $HOME/.bash_prof_local ]; then
  echo "Found existing bash prof local as a link..."
  echo " Removing bash_prof_local symbolic link..."
  rm -v $HOME/.bash_prof_local
fi
if [ -e $HOME/.bash_prof_local ]; then
  echo "Found existing bash_prof_local as a file..."
  echo " Making bash_prof_local bck..."
  mv -v $HOME/.bash_prof_local $HOME/.bash_prof_local_bck_$DAT
fi

if [ -L $HOME/.gitignore_global ]; then
  echo "Found existing global git ignore as a link..."
  echo " Removing symbolic link..."
  rm -v $HOME/.gitignore_global
fi
if [ -e $HOME/.gitignore_global ]; then
  echo "Found existing global git ignore as a file..."
  echo " Making  bck..."
  mv -v $HOME/.gitignore_global $HOME/.gitignore_global_bck_$DAT
fi

echo "Linking files..."
ln -sv `pwd`/gitignore_global $HOME/.gitignore_global
ln -sv `pwd`/bash_prof_local_cori $HOME/.bash_prof_local
echo "Done."
