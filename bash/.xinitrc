#!/bin/sh
alias sudo='sudo '

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# start the window manager
exec sway
