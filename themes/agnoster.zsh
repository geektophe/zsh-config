# vim:ft=zsh ts=4 sw=4 sts=4
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#

# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
SEGMENT_SEPARATOR='\uE0B0'
BRANCH='\uE0A0'
GEAR='\u2699'
CHECKX='\u2717'
LIGHT='\u26A1'
FQDN=$(hostname)

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.

prompt_segment() {
	local bg fg
	[[ -n $1 ]] && bg="%K{$1}" || bg="%k"
	[[ -n $2 ]] && fg="%F{$2}" || fg="%f"

	if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
		echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
	else
		echo -n "%{$bg%}%{$fg%} "
	fi

	CURRENT_BG=$1
	[[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments

prompt_end() {
	if [[ -n $CURRENT_BG ]]; then
		echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
	else
		echo -n "%{%k%}"
	fi

	echo -n "%{%f%}"
	CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)

prompt_context() {
	local user=`whoami`

	if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
		prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
	fi
}

# Git: branch/detached head, dirty status

prompt_git() {
	local ref dirty

	if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
		ZSH_THEME_GIT_PROMPT_DIRTY='±'
		dirty=$(parse_git_dirty)
		ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"

		if [[ -n $dirty ]]; then
			prompt_segment yellow black
		else
			prompt_segment green black
		fi

		echo -n "${ref/refs\/heads\//${BRANCH} }$dirty"
	fi
}

# Dir: current working directory

prompt_dir() {
	if [[ ${FQDN} =~ \.dev\. ]] || [[ ${FQDN} =~ \.local ]]; then
		prompt_segment green black '%~'
	elif [[ ${FQDN} =~ (baldr|freyr) ]] ; then
		prompt_segment magenta black '%~'
	else
		prompt_segment blue black '%~'
	fi
}

prompt_date() {
	prompt_segment black white

	echo -n '%D{[%H:%M:%S]}'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?

prompt_status_prompt() {
	local symbols
	symbols=()
	[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}${CHECKX}"
	[[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}${LIGHT}"
	[[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}${GEAR}"
	[[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_shell() {

	if [[ $UID -eq 0 ]] then
		prompt_segment yellow black
		echo -n '#'
	else
		if [[ ${FQDN} =~ \.dev\. ]] || [[ ${FQDN} =~ \.local ]]; then
			prompt_segment green black
		elif [[ ${FQDN} =~ (baldr|freyr) ]] ; then
			prompt_segment magenta black
		else
			prompt_segment blue black
		fi
		echo -n '$'
	fi
}

prompt_status_rps1() {
	if [[ $RETVAL -eq 0 ]]; then
		prompt_segment green black
	else
		prompt_segment red black
	fi
	echo -n '%?'
}


## Main prompt

build_prompt1() {
	RETVAL=$?
	prompt_status_prompt
	prompt_context
	prompt_dir
	prompt_git
	prompt_end
}

build_prompt2() {
	prompt_shell
	prompt_end
}

build_rps1() {
	RETVAL=$?
	prompt_date
	prompt_status_rps1
	prompt_end
}

# ╭─
PROMPT='${%f%b%k%}$(build_prompt1)
$(build_prompt2) '
RPS1='${%f%b%k%}$(build_rps1)'
