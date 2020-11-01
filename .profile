#!/bin/sh

if [ -d ~/lan/bin ]; then
	  PATH=~/lan/bin:$PATH
fi
if [ -d ~/.emacs.d/bin ]; then
	PATH=~/.emacs.d/bin:$PATH
fi
export PATH

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
