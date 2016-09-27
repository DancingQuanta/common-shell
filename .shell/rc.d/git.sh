# Delete git index.lock if it is still there
kick() {
if [ -f ./.git/index.lock ]; then
	echo "Unlocking..."
	rm -f ./.git/index.lock
else
	echo "Either .git not found or the git repo is not locked"
fi
}

# Github hub
alias git=hub

# BFG repo-cleaner
BFG=$HOME/bin/bfg.jar
bfg() {
  echo $BFG
  if [ -f $BFG ]; then
    if [[ $OSTYPE == "linux" ]]; then
      java -jar $BFG $@
    elif [[ $OSTYPE == "cygwin" ]]; then
      java -jar $(cygpath -w -a $BFG) $@
    fi
  else
    echo "Ensure bfg.jar is in ~/bin/"
  fi
}
