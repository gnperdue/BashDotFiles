# keep core dumps
ulimit -c unlimited

# turn on extended pattern matching
# shopt -s extglob
# shopt -s nullglob 

export PATH=$PATH:~/Scripts:~/Dropbox/UnixSettings/LocalScripts

# move /usr/loca/bin up front for brew
#export PATH=/usr/local/bin:$PATH
#export PATH=$PATH:~/Scripts
## Adding Racket to my PATH
#export PATH=/Applications/Racket\ v5.3.1/bin:$PATH
# Haskell cabal
#export PATH=$HOME/.cabal/bin:$PATH

# Boost
# Uncomment if you need it...
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/boost_1_53_0/lib

# Scala & Java
# export CLASSPATH=
#export JAVA_HOME=$(/usr/libexec/java_home)
## export SCALA_HOME=/usr/local/Cellar/scala/2.10.0/libexec/
## export SCALA_HOME=/usr/local/Cellar/scala29/2.9.2/libexec/
## export JAVACMD=drip
## export DRIP_SHUTDOWN=30
#export SBT_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:PermSize=128M -XX:MaxPermSize=512M"
#alias scala29=/usr/local/Cellar/scala29/2.9.2/libexec/bin/scala
# nailgun
#export NAILGUNLOC=/Users/gnperdue/Documents/Programming/Java/nailgun/nailgun-server/target


# Tiger fix for "man"
export MANPATH=/usr/share/man:$MANPATH

# enable xterm to support colors
export TERM=xterm-color
# enable colors
export CLICOLOR=1
# set ls colors, see man page for definitions
#               1 2 3 4 5 6 7 8 9 1011
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LSCOLORS=Exfxcxdxbxegedabagacad

#export PS1="\w> "
#PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}"; echo -ne "\007"'
#PROMPT_COMMAND='echo -ne "\033]0;LOCAL"; echo -ne "\007"'

# colours for use in prompts
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"

BRIGHTRED="\[\e[1;31m\]"
BRIGHTBLUE="\[\e[1;34m\]"
BRIGHTCYAN="\[\e[1;36m\]"

NOCOLOR="\[\e[0m\]"

# colours for use in echo -e statements
ECHORED="\e[0;31m"
ECHONOCOLOR="\e[0m"

#
# Prompt
#

# With machine name...
# export PS1="${GREEN}\h:${BLUE}\W${RED}\$ ${NOCOLOR}"
# With no machine name...
export PS1="${BLUE}\W${RED}\$ ${NOCOLOR}"

#
# Title bar
#
# note that is different than the version used in the old prompt-based solution
# turned this off because it had issues with `%`
# OPENTITLEBAR="\033]0;"
# CLOSETITLEBAR="\007"
# trap 'printf "${OPENTITLEBAR} `history 1 | cut -b8-` - `pwd` ${CLOSETITLEBAR}"' DEBUG

# Use vim keystrokes to edit the command line (use <esc> to enter Normal Mode, <i> to return to Insert Mode).
#set -o vi

# source ~/.profile
export EDITOR=vim

# git stuff
export GIT_EDITOR=vim


#MINERvA specific
export CVS_RSH=ssh
# New CVS ROOT for v8r0+ software...
##export CVSROOT=minervacvs@cdcvs.fnal.gov:/cvs/mnvsoft
# Default to using the Minerva Doc CVS repo on this computer.
export CVSROOT=p-minervadoc@cdcvs.fnal.gov:/cvs/projects/minervadoc

#For Ruby, which I don't do really... at least not yet...
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function


function console () {
if [[ $# > 0 ]]; then
  query=$(echo "$*"|tr -s ' ' '|')
  tail -f /var/log/system.log|grep -i --color=auto -E "$query"
else
  tail -f /var/log/system.log
fi
}

function hgrep () {
if [[ $# == 1 ]]; then
  history | grep $1 | grep -v grep
else
  history
fi
}

# Check aliases with `type <alias name>`

# Configure Root (5.34)
#  Script sets ROOTSYS, updates PATH, LD_LIBRARY_PATH, and DYLD_LIBRARY_PATH...
#source /Users/gnperdue/Software/root/bin/thisroot.sh 
# alias root="source ${HOME}/Software/root/bin/thisroot.sh; root -l"

#Needed for Tiger
alias ssh="ssh -Y"
#alias ssh="ssh -Y -x"


# Generic 
alias kinit="kinit -A"
alias h="history"
alias hless="history | less"
alias htail="history | tail"
alias lsp="ls"
alias ls="ls -Fh"
alias ll="ls -l"
alias kk="ll"
alias llt="ls -lrt"
alias dir="ls -l"
alias la="ls -a"
alias lsa="ls -al"
alias llh="ll -h"
alias l="ls"
alias cls="clear; ls"
alias rmd="rm *~"
#alias wemacs="/usr/bin/emacs"
alias s="source ~/.bashrc"
alias xterm="xterm -sb -rightbar -sl 128"
alias df="df -H"
alias du="du -h"
alias cmore="clear; more"
alias factoryvim="vim -u NONE -N"
alias essentialvim="vim -u $HOME/.essential.vim"
alias cdp="cd ~/Projects"
alias chkpath="echo $PATH | tr \":\" \"\n\" | sort"
alias emacs="emacs -nw"
alias bim="vim -u $HOME/Dropbox/UnixSettings/Vim/VimConfig/essential.vim"

# Coding Stuff
#alias rracket="racket -il readline"

# Typos!
alias sl="ls"
alias ks="ls"
alias mroe="more"
alias moer="more"
alias mero="more"
alias mreo="more"
alias pwn="echo You meant PWD.  pwnd.  ;pwd"

# Chicago-HEP specific
alias shep="ssh perdue@hep.uchicago.edu"

# Rochester specific
alias spas="ssh perdue@shell.pas.rochester.edu"

# NIU
alias gaea="ssh perdue@gaea.niu.edu"

# FNAL SCD
alias cluck="ssh perdue@cluck.fnal.gov"
alias tev="ssh perdue@tev.fnal.gov"

# LBNE
alias lbne01="ssh perdue@lbnegpvm01.fnal.gov"
alias lbne02="ssh perdue@lbnegpvm02.fnal.gov"

# Minerva
alias minerva01="ssh perdue@minerva01.fnal.gov"
alias minerva05="ssh perdue@minerva05.fnal.gov"
alias shnr0="ssh nearonline@mnvnearline0.fnal.gov"
alias shnr1="ssh nearonline@mnvnearline1.fnal.gov"
alias shnr2="ssh nearonline@mnvnearline2.fnal.gov"
alias shnr3="ssh nearonline@mnvnearline3.fnal.gov"
alias shnr4="ssh nearonline@mnvnearline4.fnal.gov"
alias nearline1="ssh nearonline@mnvnearline1.fnal.gov"
alias nearline2="ssh nearonline@mnvnearline2.fnal.gov"
alias nearline3="ssh nearonline@mnvnearline3.fnal.gov"
alias nearline4="ssh nearonline@mnvnearline4.fnal.gov"
alias mnvnearline1="ssh nearonline@mnvnearline1.fnal.gov"
alias mnvnearline2="ssh nearonline@mnvnearline2.fnal.gov"
alias mnvnearline3="ssh nearonline@mnvnearline3.fnal.gov"
alias mnvnearline4="ssh nearonline@mnvnearline4.fnal.gov"
alias shfx9="ssh perdue@flxi09.fnal.gov"
alias shfx10="ssh perdue@flxi10.fnal.gov"
alias shfb32="ssh perdue@flxb32.fnal.gov"
alias shfb33="ssh perdue@flxb33.fnal.gov"
alias shfb34="ssh perdue@flxb34.fnal.gov"
alias shfb36="ssh perdue@flxb36.fnal.gov"
alias shmt1="ssh perdue@minervatest01.fnal.gov"
alias shmtu1="ssh tbuser@minervatest01.fnal.gov"
alias minervatest01="ssh tbonline@minervatest01.fnal.gov"
alias minervatest02="ssh minerva@minervatest02.fnal.gov"
alias minervatest03="ssh minerva@minervatest03.fnal.gov"
alias minervatest03="ssh minerva@minervatest04.fnal.gov"
alias shmt2="ssh perdue@minervatest02.fnal.gov"
alias shmt3="ssh perdue@minervatest03.fnal.gov"
alias shmt4="ssh perdue@minervatest04.fnal.gov"
alias shmt5="ssh minerva@minervatest05.fnal.gov"
# alias if01="ssh perdue@if01.fnal.gov"
# alias if02="ssh perdue@if02.fnal.gov"
# alias if03="ssh perdue@if03.fnal.gov"
# alias if04="ssh perdue@if04.fnal.gov"
# alias if05="ssh perdue@if05.fnal.gov"
# alias shif1="ssh perdue@if01.fnal.gov"
# alias shif2="ssh perdue@if02.fnal.gov"
# alias shif3="ssh perdue@if03.fnal.gov"
# alias shif4="ssh perdue@if04.fnal.gov"
alias shif4m="ssh mnvonline@if04.fnal.gov"
alias shif4t="ssh tbonline@if04.fnal.gov"
alias shif5="ssh perdue@if05.fnal.gov"
alias shmmr="ssh mnvonline@mnvonlinemaster.fnal.gov"
alias shmlg="ssh mnvonline@mnvonlinelogger.fnal.gov"
alias shm0="ssh mnvonline@mnvonline0.fnal.gov"
alias shm1="ssh mnvonline@mnvonline1.fnal.gov"
alias shm2="ssh mnvonline@mnvonline2.fnal.gov"
alias shmb1="ssh mnvonline@mnvonlinebck1.fnal.gov"
alias shmb2="ssh mnvonline@mnvonlinebck2.fnal.gov"
alias shtb0="ssh tbonline@mnvtbonline0.fnal.gov"
alias shtb1="ssh tbonline@mnvtbonline1.fnal.gov"
alias shtb2="ssh tbonline@mnvtbonline2.fnal.gov"
alias mnvtbonline0="ssh tbonline@mnvtbonline0.fnal.gov"
alias mnvtbonline1="ssh tbonline@mnvtbonline1.fnal.gov"
alias mnvtbonline2="ssh tbonline@mnvtbonline2.fnal.gov"
alias tbif03="ssh tbonline@if03.fnal.gov"
alias tbif04="ssh tbonline@if04.fnal.gov"
alias minervarc="ssh minerva@minerva-rc.fnal.gov"
alias minervabm="ssh minerva@minerva-bm.fnal.gov"
alias minervaevd="ssh minerva@minerva-evd.fnal.gov"
alias minervaom="ssh minerva@minerva-om.fnal.gov"
alias gpvm01="ssh perdue@minervagpvm01.fnal.gov"
alias gpvm02="ssh perdue@minervagpvm02.fnal.gov"
alias gpvm03="ssh perdue@minervagpvm03.fnal.gov"
alias gpvm04="ssh perdue@minervagpvm04.fnal.gov"
alias gpvm05="ssh perdue@minervagpvm05.fnal.gov"

# GENIE stuff
alias hepforge="ssh gnperdue@login.hepforge.org"
alias genie01="ssh perdue@geniegpvm01.fnal.gov"

# Local stuff
source $HOME/.bash_prof_local
