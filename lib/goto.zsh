#!/usr/bin/env zsh
# Goto functions definition
#

function _goto-folder {
	local FOLDER=$1

	if [[ -d $FOLDER ]]; then
		cd $FOLDER
		if git branch --no-color --list | grep -q '^\* master$'; then
		  git pull --rebase
		fi
	fi
}

function goto-dnsmaster {
	_goto-folder $HOME/git/dnsmaster/conf/zones/public
}

function goto-bcfg2 {
	_goto-folder $HOME/git/bcfg2
}

function goto-nagios {
	_goto-folder $HOME/git/nagios
}

function goto-dontpanic {
	_goto-folder $HOME/git/dontpanic
}

function goto-dm {
	_goto-folder $HOME/git/dm
}

function goto-awesome {
	_goto-folder $HOME/.config/awesome
}

function goto-dhcp {
	_goto-folder $HOME/git/dhcp
}

function goto-shinken {
	_goto-folder $HOME/git/shinken
}

function goto-salt {
	_goto-folder $HOME/git/salt/salt
}

function goto-saltprivate {
	_goto-folder $HOME/git/salt-private
}

function goto-pkg {
	cd $HOME/git/pkg/git
}

function goto-fred {
	_goto-folder $HOME/git/fred-config
}
