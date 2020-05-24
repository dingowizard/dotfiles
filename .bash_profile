#
# ~/.bash_profile
#

source .profile
if [[ $- == *i* ]]; then . ~/.bashrc; fi

# opam configuration
test -r /home/dave/.opam/opam-init/init.sh && . /home/dave/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true


