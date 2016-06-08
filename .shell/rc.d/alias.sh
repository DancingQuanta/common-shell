##########
# Aliases
##########

# trick to make aliases available when using sudo
alias sudo='sudo '

# Change default shell
alias changeshell='chsh -s $(which $1) && $1'

# Go to personal bin folder
alias bin='cd ~/bin'

# Filesystem actions
for c in cp rm ln chmod chown rename; do
    alias $c="$c -v"
done

for a in cp rm ln; do
    alias $a="$a -i"
done

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ll='ls -hal'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias .....='cd ../../../.. && ls'
alias back='cd $OLDPWD && ls'
alias extract='tar -zxvf'

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
if which pygmentize &> /dev/null; then
  alias hcat='pygmentize -g -O style=trac -f terminal256'
fi

# use colordiff if available
if which colordiff &> /dev/null; then
  alias diff='colordiff'
fi

# hexdump using od
alias hd='od -Ax -tx1z -v'

alias rsync="rsync --partial --progress --human-readable --compress"

# alias for using rsync with sudo and ssh
alias rrsync='rsync --rsync-path sudo\ rsync -rvze ssh'

## System

alias poweroff='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

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

# Cygwin

alias open=cygstart

alias wiki='cd /cygdrive/c/Users/andre/Dropbox/wiki'

# Authoring

alias texspell='aspell --lang=en_GB --mode=tex check'

## Aliases and functions
# Edit aliases and functions

# Location of aliases and functions
alias aliasesloc="$HOME/.shell/aliases.sh"
alias functionsloc="$HOME/.shell/functions.sh"

# Edit aliases and activate the changes
alias aliases='sudo $EDITOR $aliasesloc && source $aliasesloc'

# Show aliases
alias showaliases='more $aliasesloc'

# Edit functions and activate the changes
alias functions='sudo $EDITOR $functionsloc && source $functionsloc'

# Show functions
alias showfunctions='more $functionsloc'

