#!/bin/bash

SCRIPT=$1
LOGFILE=`echo -e $SCRIPT | perl -ne 'chomp $_;@l=split("\\\.",$_);print @l[0];'`
LOGFILE="${LOGFILE}_`hostname`_`date +%Y-%m-%d`.log"
echo "Logging install to $LOGFILE"
echo "bash $SCRIPT | tee $LOGFILE"
bash $SCRIPT | tee $LOGFILE
# python pyverchecker.py >> $LOGFILE
