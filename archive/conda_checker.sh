#!/bin/bash

PACKS="
numpy
atari-py
gym
ptan
opencv-python
scipy
torch
torchvision
tensorboard-pytorch
tensorflow
tensorboard
pybullet
matplotlib
"

for pack in $PACKS
do
    conda search $pack
done
