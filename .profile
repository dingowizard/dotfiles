#!/bin/sh

if [ -d ~/lan/bin ]; then
	  PATH=~/lan/bin:$PATH
fi
if [ -d ~/.emacs.doom/bin ]; then
	PATH=~/.emacs.doom/bin:$PATH
fi
export PATH

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
