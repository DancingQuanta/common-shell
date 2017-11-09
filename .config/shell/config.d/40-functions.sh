
# shell version of ord() and chr()
ord() { printf "0x%x\n" "'$1"; }
chr() { printf $(printf '\\%03o\\n' "$1"); }

# highlight text
highlight() { e="$1"; shift; grep --color=always -Eih "$e|$" "$@"; }

# grep process table
psgrep() { psc |grep -v grep |grep -i --color=auto "$@"; }

pspid() { ps xao pid,args |grep -v grep |grep -i "$@" |awk '{print $1}'; }

#Search processes
searchps() {
if [ ! -z $1 ] ; then
	echo "Grepping for processes matching $1..."
	ps aux | head -n 1
	ps aux | grep $1 | grep -v grep
else
	echo "!! Need name to grep for"
fi
}

# killall alternative
pskill() {
  # Check whether a signal was given
  if [[ "$1" =~ '^-[[:alnum:]]+' ]]; then
    SIGNAL=$1
    shift
  else
    SIGNAL="-TERM"
  fi

  PIDS=$(pspid $@)
  if [ -n "$PIDS" ]; then
    echo $PIDS |xargs kill $SIGNAL
  else
    echo "No processes matching '$@' found" 1>&2
  fi
}

# copy and go to dir
cpg () {
if [ -d "$2" ]
then
	cp $1 $2 && cd $2
else
	cp $1 $2
fi
}

# move and go to dir
mvg () {
if [ -d "$2" ]
then
	mv $1 $2 && cd $2
else
	mv $1 $2
fi
}

#backup file
backup() {
	mv $1{,.bak}
}

# Reverse to backup, restore!!!
restore() {
	mv $1{.bak,}
}

##Make sure the file is linux readable!! Screw DOS! Replace DOS line ending with linux EOL
native() {
	sed -i s/{ctrl+v}{ctrl+m}// $1
}

## Find something
ff() {
	find . -name $@ -print
}

# Find top largest files
large() {
	find / -type f -size +10000k -exec ls -lh {} \; | awk '{ print $NF ": " $5 }'
}

## prevent grep adding line numbers to standard output to pipe eg check it output is to tty or not
ngrep() {
	if [[ -t 0 && -t 1 ]]
	then 
        command grep -n "$@"
    else 
        command grep "$@"
    fi
}
alias grep='ngrep'

## Move a running process to current screen
movehere() {
reptyr $(pgrep $1)
}

## Moniter a process
topit() {
top -p $(pgrep -d , $1)
}

## Time a process
timeps() {
	time $@ -i -c exit
}

viewps() {
	/usr/bin/time $@ -v
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

# Calculate the difference in whole days between two dates, ignoring timezone changes
datediff() {
    echo $(( ($(date -u -d $1 +%s) - $(date -u -d $2 +%s)) / 86400)) 
}

gpgcheckpass() {
echo $2 | gpg -q --sign --local-user "$1" --passphrase-fd 0 --output /dev/null --yes "1234" && (echo 'CORRECT passphrase' && break)
}

# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
# credit: http://nparikh.org/notes/zshrc.txt
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar -jxvf $1;;
      *.tar.gz) tar -zxvf $1;;
      *.bz2) bunzip2 $1;;
      *.dmg) hdiutil mount $1;;
      *.gz) gunzip $1;;
      *.tar) tar -xvf $1;;
      *.tbz2) tar -jxvf $1;;
      *.tgz) tar -zxvf $1;;
      *.zip) unzip $1;;
      *.ZIP) unzip $1;;
      *.pax) cat $1 | pax -r;;
      *.pax.Z) uncompress $1 --stdout | pax -r;;
      *.Z) uncompress $1;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

recent() {
  find . -type f -printf '%T@ %p\n' | sort -n | tail -$1 | cut -f2- -d" "
}

## Functions to manipulate paths

# Remove a path from PATH
remove_from_path() {
  [ -d $1 ] || return
  # Doesn't work for first item in the PATH but don't care.
  export PATH=$(echo ":$PATH:" | sed "s@:$1:@:@g;s@^:\(.*\):\$@\1@") 2>/dev/null
}

# Add to beginning of path,
prepend_path() {
  [ -d $1 ] || return
  $(echo ":$PATH:" | grep -q ":$1:") && remove_from_path "$1"
  export PATH="$1:$PATH"
}

append_path() {
  [ -d "$1" ] || return
  $(echo ":$PATH:" | grep -q ":$1:") && remove_from_path "$1"
  export PATH="$PATH:$1"
}
