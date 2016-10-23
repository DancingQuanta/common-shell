#!/bin/sh

# Helper functions for markdown files

# Search in markdown files
gmd() {
  grep "$1" -r --include="*.md" .
}

# Search in rst files
grst() {
  grep "$1" -r --include="*.rst" .
}

# Search and replace in markdown files
srmd() {
  echo "Replacing $1 with $2"
  find . -type f -name "*.md" -exec \
    sed -i 's/'$1'/'$2'/g' {} +
}

# List most recently changed files
rmd() {
  find . -type f -name "*.md" -printf '%TY-%Tm-%Td %TT %p\n' | sort -r
}

