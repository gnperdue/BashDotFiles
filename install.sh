#!/usr/bin/env bash

# Check to see if the bash profiles already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

if [ -e $HOME/.bash_profile ]; then
  echo "Found existing bash profile"
  if [ -L $HOME/.bash_profile ]; then
    echo " Removing symbolic link..."
    rm $HOME/.bash_profile_local
  else
    echo " Making bash profile bck file..."
    mv $HOME/.bash_profile $HOME/.bash_profile_bck_$DAT
  fi
fi

if [ -e $HOME/.bash_prof_local ]; then
  echo "Found existing bash_prof_local"
  if [ -L $HOME/.bash_prof_local ]; then
    echo " Removing bash_prof_local symbolic link..."
    rm $HOME/.bash_prof_local
  else
    echo " Making bash_prof_local bck..."
    mv $HOME/.bash_prof_local $HOME/.bash_prof_local_bck_$DAT
  fi
fi

echo "Linking files..."
ln -s .bash_profile $HOME/.bash_profile
echo "You need to get around to configuring a look up for the local!"

echo "Done."
