#!/bin/sh

# Helper functions for markdown files

# Search in files
gmd() {
  grep "$1" -r --include="*.md" .
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

