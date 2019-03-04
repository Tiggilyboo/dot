# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alert: notify-send
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# xed
alias xed='nvim'
alias sudo='sudo '
