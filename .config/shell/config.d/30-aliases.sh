#!/usr/bin/env sh
## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## 30-aliases.sh
## shell agnostic aliases

# trick to make aliases available when using sudo
[[ -x $(command -v sudo) ]] && alias sudo='sudo '

# Change default shell
alias changeshell='chsh -s $(which $1) && $1'

# Go to personal bin folder
alias bin='cd ~/.local/bin'

# Filesystem actions
for c in chmod chown rename; do
    alias $c="$c -v"
done

for a in cp rm ln; do
    alias $a="$a -iv"
done

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ll='ls -hal'
alias la='ls -A'
alias l='ls -CF'

## permissions
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'
alias perm='stat --printf "%a %n \n "' # requires a file name e.g. perm file

## Text

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#show text files without comments
alias nocomment='grep -Ev '\''^(#|$)'\'''

#less and more line numbers
alias less='less -N'

# syntax highlight
[[ -x $(command -v pygmentize) ]] && alias hcat='pygmentize -g -O style=trac -f terminal256'

# use colordiff if available
[[ -x $(command -v pygmentize) ]] && alias diff='colordiff'

# hexdump using od
alias hd='od -Ax -tx1z -v'

# Rsync
alias rsync="rsync --partial --progress --human-readable --compress"

#System info
alias name='uname -srvmo'
alias version='vcgencmd version'
alias brag='clear && uname -srvmo && echo && cat /proc/version && echo && ls -l /boot/kernel.img && echo && vcgencmd version && echo && free -h && echo && df -h / && echo'

# Diskspace
alias df='df -H'
alias du='du -ch'

# Memory
alias meminfo='free -m -l -t -h'

# Get top process eating memory
alias mem='ps aux --sort -rss | more'
alias mem10='ps aux --sort -rss | head -n 11'

# Get top process eating cpu
alias cpu='ps aux --sort -cpu | more'
alias cpu10='ps aux --sort -cpu | head -n 11'
alias psc='ps xawfo pid,user,args'

#Time
alias now='date +"%T'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

## Aliases and functions
# Edit aliases and functions

# Location of aliases and functions
alias aliasesloc="$HOME/.config/shell/config.d/30-aliases.sh"
alias functionsloc="$HOME/.config/shell/config.d/40-functions.sh"

# Edit aliases and activate the changes
alias aliases='$EDITOR $aliasesloc && source $aliasesloc'

# Show aliases
alias showaliases='more $aliasesloc'

# Edit functions and activate the changes
alias functions='$EDITOR $functionsloc && source $functionsloc'

# Show functions
alias showfunctions='more $functionsloc'
