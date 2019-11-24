# needed to use z command:
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# enable bash-completion package
source /usr/share/bash-completion/bash_completion

# lookup package if command not found
source /usr/share/doc/pkgfile/command-not-found.bash

# ignore duplicates in history
export HISTCONTROL=ignoredups

# Zsh-like command lookup
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

# for dotfiles repo:
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# aliases
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias e='emacsclient -nc'
