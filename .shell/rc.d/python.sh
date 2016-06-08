# Useful python aliases and functions

# Update pip modules
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# Compile python scripts, useful for checking for any syntax issues
alias pycheck="python -m py_compile"
