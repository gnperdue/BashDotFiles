# enable colors
export CLICOLOR=1
# set ls colors, see man page for definitions
#               1 2 3 4 5 6 7 8 9 1011
export LSCOLORS=Exfxcxdxbxegedabagacad

# Generic aliases
# `-g` flag -> "global", so these will expand anywhere
alias kinit="kinit -A"
alias h="history"
alias -g hless="history | less"
alias -g htail="history | tail"
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
alias s="source ~/.zshrc"
alias df="df -H"
alias du="du -h"
alias cmore="clear; more"

# keep emacs in-window on Mac
alias emacs="emacs -nw"

# no frills Vims
alias factoryvim="vim -u NONE -N"
#alias essentialvim="vim -u $HOME/.essential.vim"
alias bim="vim -u $HOME/Dropbox/UnixSettings/Vim/VimConfig/essential.vim"

# Functions
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

# path stuff
export PATH=$PATH:~/PersonalScripts:~/Dropbox/UnixSettings/LocalScripts
eval $(/opt/homebrew/bin/brew shellenv)
# gem for jekyll, ruby stuff - problems on M1, blow this up and come back to it (2021-02-08)
#export PATH=$PATH:/Users/perdue/.gem/ruby/2.6.0/bin
# Haskell stuff - needs rationalization, probably
#export PATH="$HOME/.cabal/bin:/Users/perdue/.ghcup/bin:$PATH"
[ -f "/Users/perdue/.ghcup/env" ] && source "/Users/perdue/.ghcup/env" # ghcup-env
# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Python and conda stuff
setupminiconda3() {
  # take anaconda out of the PATH...
  export PATH="${PATH/\/Users\/perdue\/anaconda\/bin:/}"
  # take miniconda3,2 out of the PATH...
  export PATH="${PATH/\/Users\/perdue\/miniconda3\/bin:/}"
  export PATH="${PATH/\/Users\/perdue\/miniconda2\/bin:/}"
  # add miniconda3 to PATH
  #export PATH="/Users/perdue/miniconda3/bin:$PATH"
  source ~/miniconda3/etc/profile.d/conda.sh
}
# by DEFAULT --- set up miniconda3
setupminiconda3

#alias py3j="setupminiconda3 && conda activate py3j"              # jupyter, ipython
#alias py3trch="setupminiconda3 && conda activate py3trch"        # pytorch
#alias py3tf="setupminiconda3 && . activate py3tf"                 # tensorflow
alias py3qec="setupminiconda3 && conda activate py3qec"           # FNAL quantum error correction
alias py3cirq="setupminiconda3 && conda activate py3cirq"             # cirq, data science basics
#alias py3astro="setupminiconda3 && . activate py3astro"          # astropy, some ml stuff
#alias py3dmda="setupminiconda3 && . activate py3dmda"            # deep merge domain adaptation
#alias py3fast="setupminiconda3 && . activate py3fast"            # PyTorch 1.?, fastai
#alias py3fast2="setupminiconda3 && . activate py3fast2"          # PyTorch 1.?, fastai2
#alias py3gdl="setupminiconda3 && . activate py3gdl"              # TF2 based generative deep learning
#alias py3qutip="setupminiconda3 && . activate py3qutip"          # qutip stuff
#alias py3q="setupminiconda3 && . activate py3q"                  # cirq, tfq, qutip, qiskit
#alias py3lqcqiskit="setupminiconda3 && . activate py3lqcqiskit"  # qiskit, etc.
#alias py3qiskit="setupminiconda3 && . activate py3qiskit"        # qiskit, etc.

# PATH used here is the PATH we end up with in the script
alias chkpath="echo $PATH | tr \":\" \"\n\" | sort"

