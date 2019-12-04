#!/bin/sh

if [ -d ~/Dropbox/bin ]; then
	  PATH=~/Dropbox/bin:$PATH
fi
export PATH

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
