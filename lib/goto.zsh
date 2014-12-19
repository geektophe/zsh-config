#!/usr/bin/env zsh
# Goto functions definition
#

function _goto-folder {
	local FOLDER=$1

	if [[ -d $FOLDER ]]; then
		cd $FOLDER
		git pull
	fi
}

function goto-dnsmaster {
	_goto-folder $HOME/conf/dnsmaster/conf/zones/public
}

function goto-bcfg2 {
	_goto-folder $HOME/conf/bcfg2
}

function goto-nagios {
	_goto-folder $HOME/conf/nagios
}

function goto-dontpanic {
	_goto-folder $HOME/conf/dontpanic
}

function goto-dm {
	_goto-folder $HOME/conf/dm
}

function goto-awesome {
	_goto-folder $HOME/.config/awesome
}

function goto-dhcp {
	_goto-folder $HOME/conf/dhcp
}

function goto-shinken {
	_goto-folder $HOME/conf/shinken
}

function goto-salt {
	_goto-folder $HOME/conf/salt
}

function goto-pkg {
	cd $HOME/conf/pkg/git
}

function goto-fred {
	_goto-folder $HOME/conf/fred-config
}
