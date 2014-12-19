#!/usr/bin/env zsh
# Opens jira tickets directly in web browser
#

function jira {
	local TICKET=$1
	if echo $TICKET | grep -q '^[0-9]\{4\}$'; then
		TICKET="INFRA-$TICKET"
	elif echo $TICKET | grep -q '^[0-9]\{5\}$'; then
		TICKET="DAILY-$TICKET"
	else
		echo "Could not guess ticket project..."
		exit 1
	fi
	firefox https://jira.dailymotion.com/browse/$TICKET

}
