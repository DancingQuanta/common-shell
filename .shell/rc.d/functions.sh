
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

##Everytime you change directory, list files and directory
cdls() {
	cd "$@" && ls
}

## Delete a directory
rmdir() {
	rm -rf $@
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

gmd() {
# Grep in markdown files
grep "$1" -r --include="*.md" .
}

gmm() {
# Grep in mm files
grep "$1" -r --include="*.mm" .
}

gtxt() {
# Grep in txt files
grep "$1" -r --include="*.txt" .
}

pdfgrep() {
find . -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep --with-filename --label="{}" --color "'"$@"'"' \;
}

pdfdia() {
find . -name '*.pdf' | while read -r f
	do
	#ERR=
	if $((pdftotext "$f" - > /dev/null) 2>&1) &> /dev/null; then
		echo "$f" was ok;
	else
		mv "$f" "$f.broken";
		echo "$f is broken";   
	fi;
	done
}

gpgcheckpass() {
echo $2 | gpg -q --sign --local-user "$1" --passphrase-fd 0 --output /dev/null --yes "1234" && (echo 'CORRECT passphrase' && break)
}
