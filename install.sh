#!/usr/bin/env bash

# Check to see if the bash profiles already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

if [ -e $HOME/.bash_profile ]; then
  echo "Found existing bash profile as a file..."
  echo " Making bash profile bck file..."
  mv -v $HOME/.bash_profile $HOME/.bash_profile_bck_$DAT
fi
if [ -L $HOME/.bash_profile ]; then
  echo "Found existing bash profile as a link..."
  echo " Removing bash_profile symbolic link..."
  rm -v $HOME/.bash_profile
fi

if [ -e $HOME/.bash_prof_local ]; then
  echo "Found existing bash_prof_local as a file..."
  echo " Making bash_prof_local bck..."
  mv -v $HOME/.bash_prof_local $HOME/.bash_prof_local_bck_$DAT
fi
if [ -L $HOME/.bash_prof_local ]; then
  echo "Found existing bash prof local as a link..."
  echo " Removing bash_prof_local symbolic link..."
  rm -v $HOME/.bash_prof_local
fi

echo "Linking files..."
ln -sv `pwd`/bash_profile $HOME/.bash_profile
echo " "
echo "You need to get around to configuring a look up for the local!"
echo " Options include: "
echo "   ln -sv `pwd`/bash_prof_local_MacBook_2010 \$HOME/.bash_prof_local"
echo "   ln -sv `pwd`/bash_prof_local_iMac_2013 \$HOME/.bash_prof_local"
echo " "
echo "Done."
