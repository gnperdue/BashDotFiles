#!/usr/bin/env bash

# Check to see if the bash profiles already exist. If they do, archvie them
# into _bck files unless they are just symbolic links, in which case just
# remove the old links.

DAT=`date -u +%s`

filelist='zshrc gitignore_global'

for flnm in $filelist
do
  if [ -L $HOME/.$flnm ]; then
    echo "Found existing $flnm as a link..."
    echo " Removing $flnm symbolic link..."
    rm -v $HOME/.$flnm
  fi
  if [ -e $HOME/.$flnm ]; then
    echo "Found existing $flnm as a file..."
    echo " Making $flnm bck file..."
    mv -v $HOME/.$flnm $HOME/.${flnm}_bck_${DAT}
  fi
done

# uncomment this for Clojure
#mkdir -p $HOME/.lein
#cp lein/profiles.clj $HOME/.lein/profiles.clj

echo "Copying files..."
for flnm in $filelist
do
  cp -v `pwd`/$flnm $HOME/.$flnm
done
echo " "

# be careful with this since it will over-write a token you can't look at on
# GitHub.
#cp gitconfig ~/.gitconfig
#echo "You need to update the token in your ~/.gitconfig"
echo "Done."
