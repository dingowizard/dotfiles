#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -d ~/Dropbox/bin ]; then
	PATH=~/Dropbox/bin:$PATH
fi
export PATH

