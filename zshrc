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
alias chkpath="echo $PATH | tr \":\" \"\n\" | sort"

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
# note - if Homebrew is installed, the directory order has been set in /etc/paths (somehow)
export PATH=$PATH:~/PersonalScripts:~/Dropbox/UnixSettings/LocalScripts

# Python and conda stuff
setupminiconda3() {
  # take anaconda out of the PATH...
  export PATH="${PATH/\/Users\/perdue\/anaconda\/bin:/}"
  # take miniconda3,2 out of the PATH...
  export PATH="${PATH/\/Users\/perdue\/miniconda3\/bin:/}"
  export PATH="${PATH/\/Users\/perdue\/miniconda2\/bin:/}"
  # add miniconda3 to PATH
  export PATH="/Users/perdue/miniconda3/bin:$PATH"
}
alias py3a="setupminiconda3 && . activate py3a"                  # TF, data sci basics
alias py3astro="setupminiconda3 && . activate py3astro"          # astropy, some ml stuff
alias py3cirq="setupminiconda3 && . activate py3cirq"            # TF2.1, TFQ, cirq, data sci basics
alias py3dmda="setupminiconda3 && . activate py3dmda"            # deep merge domain adaptation
alias py3fast="setupminiconda3 && . activate py3fast"            # PyTorch 1.?, fastai
alias py3fast2="setupminiconda3 && . activate py3fast2"          # PyTorch 1.?, fastai2
alias py3gdl="setupminiconda3 && . activate py3gdl"              # TF2 based generative deep learning
alias py3qutip="setupminiconda3 && . activate py3qutip"          # qutip stuff
alias py3q="setupminiconda3 && . activate py3q"                  # cirq, tfq, qutip, qiskit
alias py3lqcqiskit="setupminiconda3 && . activate py3lqcqiskit"  # qiskit, etc.
alias py3qiskit="setupminiconda3 && . activate py3qiskit"        # qiskit, etc.
alias py3trch="setupminiconda3 && . activate py3trch"            # pytorch
