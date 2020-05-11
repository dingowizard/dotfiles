#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -d ~/Dropbox/bin ]; then
	PATH=~/Dropbox/bin:$PATH
fi
export PATH

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

# opam configuration
test -r /home/dave/.opam/opam-init/init.sh && . /home/dave/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
