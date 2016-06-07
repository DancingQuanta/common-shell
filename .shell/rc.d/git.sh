# Delete git index.lock if it is still there
kick() {
if [ -f ./.git/index.lock ]; then
	echo "Unlocking..."
	rm -f ./.git/index.lock
else
	echo "Either .git not found or the git repo is not locked"
fi
}