# A two-line colored Bash prompt (PS1) with Git branch and a line decoration
# which adjusts automatically to the width of the terminal.
# Recognizes and shows Git, SVN and Fossil branch/revision.
# Screenshot: http://img194.imageshack.us/img194/2154/twolineprompt.png
# Michal Kottman, 2012
 
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
PS_LINE=`printf -- '  %.0s' {1..200}`
function parse_git_branch {
  PS_BRANCH=''
  PS_FILL=${PS_LINE:0:$COLUMNS}
  if [ -d .svn ]; then
    PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
    return
  elif [ -f _FOSSIL_ -o -f .fslckout ]; then
    PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
    return
  fi
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(git ${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_BRANCH"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"
export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "

# fix ugly terminal colors for OTHER_WRITABLE
eval "$(dircolors ~/.dircolors)"

# needed to use z command:
#[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# fasd init:
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# for fasd
eval "$(fasd --init auto)"

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
alias e='emacsclient -c'
alias o='xdg-open'
alias less='vimpager'
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias e='emacsclient -nc'
alias ..='cd ..'
## ls
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | less'

## Safety features
alias cp='cp -i'
alias mv='mv -i'
# safer alternative w/ timeout, not stored in history:
alias rm=' timeout 3 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)

## Make Bash error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'

alias trash='trash-put'
alias del='trash-put'

# auto cd
shopt -s autocd

# rewrap lines if terminal is resized
shopt -s checkwinsize

# fix spelling mistakes when changing directories
shopt -s cdspell
# and with autocompletion
shopt -s direxpand
shopt -s dirspell

# weather report
alias weather='weather-report 10065'
