#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#

###############################################################################
#
# LIBRARIES
#
###############################################################################

# Git functions
source $HOME/.zsh/lib/git.zsh
# Goto funttions
source $HOME/.zsh/lib/goto.zsh


###############################################################################
#
# COMPLETION
#
###############################################################################

autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s


# Creates a completion cache. Very useful for time consuming commands completion.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end


# Ignore completion functions for commands you don’t have.
zstyle ':completion:*:functions' ignored-patterns '_*'

# Autocompletion menu
zstyle ':completion:*' menu select=2

# Autopletion ignores
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Extended globing
# setopt extendedglob

# Autocompletion of command line switches for aliases
setopt completealiases

# des couleurs pour la complétion
# faites un kill -9 <tab><tab> pour voir :)
zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"


###############################################################################
#
# AUTO CORRETION
#
###############################################################################

setopt correctall


###############################################################################
#
# PROMPT
#
###############################################################################

# Promt sessings.

case $TERM in
	xterm*|urxvt*)
		setopt prompt_subst
		THEME=agnoster
		source $HOME/.zsh/themes/$THEME.zsh ;;
	*)
		autoload -U promptinit
		promptinit
		prompt redhat;;
esac


###############################################################################
#
# ALIASES
#
###############################################################################

alias ls='ls --color=auto'
alias ll='ls --color=auto -lh'
alias lll='ls --color=auto -lh | less'
alias grep='grep --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vmie7='rdesktop -g 1280x800 vmie7 -d daily -u c.simon'

###############################################################################
#
# ENVIRONMENT VARIABLES
#
###############################################################################

export EDITOR=/usr/bin/vim
export GREP_COLOR=31
export GREP_OPTIONS="--exclude=.svn/* --exclude=.git/*"
export PATH=$HOME/bin:$PATH
