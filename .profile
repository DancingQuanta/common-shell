## DancingQuanta/shell-config - https://github.com/DancingQuanta/shell-config
## $HOME/.profile
## This file sets up shell environment for the shell

# load profile files from $HOME/.config/shell/profile.d
if [[ -d "$HOME/.config/shell/profile.d/" ]]; then
	for profile in $HOME/.config/shell/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Local configuration

# load profile files from $HOME/.config/shell/profile-local.d
if [[ -d "$HOME/.config/shell/profile-local.d/" ]]; then
	for profile_local in $HOME/.config/shell/profile-local.d/*.sh; do
		test -r "$profile_local" && . "$profile_local"
	done
	unset profile_local 
fi
