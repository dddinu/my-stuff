#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### ------- EXPORTS -------###

export EDITOR='vim'
export VISUAL='emacs'

### ------- ALIASES -------###

alias ls='ls --color=auto'
alias es='emacs'
alias eq='emacs -nw'
alias ec='emacsclient -c'
alias ctemp='rm -v *~'
alias sx='startxfce4'
alias lsservice='systemctl --type=service --all'
alias screensave='lavat -c yellow -R1 -k red'
alias matlab='matlab -desktop'
alias statecodes='man ps | grep "PROCESS STATE CODES" -A 11 | head -n 12'
alias togtig='source ~/scripts/toggle-tigress.bash'
alias tig='tigress --Environment=x86_64:Linux:Gcc:12.2.1'
alias figrep='~/scripts/figrep.bash'
alias google='~/scripts/google.bash'

### ------- PROMPT -------###

PS1='[\d] <\[\e[1;34m\w\[\e[0m>\n[\t] 🧙 [\u@\h]\$ '


### ------- TIGRESS SETTINGS -------###

# save the unappended path
export UNAPP_PATH=$PATH

export TIGRESS_HOME=/home/ddinu/opt/tigress/3.1
export PATH=/home/ddinu/opt/tigress/3.1:$PATH

### ------- OD-LLVM SETTINGS -------###

export PATH=/home/ddinu/obfuscation/symbex/llvm-project/build/bin:$PATH


### ------- DECORATION -------###

