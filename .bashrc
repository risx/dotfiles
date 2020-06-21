export EDITOR=/usr/local/bin/vim

set -o vi

# recursive ** 
#shopt -s globstar

# Shell return value viz (taken from arch wiki)
set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[0;34m\]'
    White='\[\e[0;37m\]'
    Red='\[\e[0;31m\]'
    Green='\[\e[0;32m\]'
    Cyan='\[\e[0;36m\]'
    Yellow='\[\e[0;33m\]'
    DarkGrey='\[\e[0;90m\]'
    Bold='\[\e[1m\]'
    Reset='\[\e[0m\]'
    if [[ $Last_Command == 0 ]]; then
        PS1="$Green"
    else
        PS1="$Red"
    fi

    PS1+="\$? "

    PS1+="$Cyan\\t "

    dir=$(echo `pwd` | ~/.b/trim.py)
    PS1+="$Blue$dir "

    git branch &>/dev/null
    if [ $? -eq 0 ]; then
        PS1+="$Yellow[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)]$Reset "
    fi
    PS1+="$White\\\$$Reset "
}
PROMPT_COMMAND='set_prompt'

HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export TERMINAL=lxterminal

test -s ~/.alias && . ~/.alias || true

export TERM='screen-256color'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

shopt -s expand_aliases
alias ls="ls -GF --color"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

export PATH=$PATH:/usr/local/bin

export EDITOR="/usr/bin/vim"

[ -s "/home/lars/.nvm/nvm.sh" ] && . "/home/lars/.nvm/nvm.sh" # This loads nvm

# this way ctrl s doesn't freeze the terminal when in vim
vim()
{
    local ret STTYOPTS="$(stty -g)"
    stty -ixon
    command vim "$@"
    ret=$?
    stty "$STTYOPTS"
    return "$ret"
}

# Caps lock <-> Escape
# setxkbmap -option caps:escape

# Local configs
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# XClip

alias "c=xclip -selection clipboard"
alias "v=xclip -o -selection clipboard"