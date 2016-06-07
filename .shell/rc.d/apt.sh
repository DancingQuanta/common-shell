# # Create useful aliases for apt cleanup commands
# if which apt-get &> /dev/null; then
  # # Remove old kernels (but the most recent, and the currently running one
  # alias apt-purge-old-kernels="apt-get purge \$(dpkg --list |egrep 'linux-image-[0-9]' |awk '{print \$3,\$2}' |sort -nr |tail -n +2 |grep -v \$(uname -r) |awk '{print \$2}' |tr '[:space:]' ' ')"

  # # Purge removed packages and unused dependencies
  # alias apt-purge-removed-packages="apt-get purge --auto-remove -y \$(dpkg -l |grep '^rc' |awk '{print \$2}' |tr '[:space:]' ' ')"
# fi

alias install='sudo apt-get update && sudo apt-get install'
alias searchapp='apt-cache search'
alias showapp='apt-cache show'
alias listapp='dpkg -l'

alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade -y && sync'
alias autoremove='sudo apt-get autoremove --purge'
alias remove='sudo apt-get remove --purge'
alias cleanall='sudo apt-get clean all'
alias rpi-update='sudo rpi-update'