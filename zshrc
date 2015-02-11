#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#

###############################################################################
#
# ENVIRONMENT VARIABLES
#
###############################################################################

fpath=($fpath $HOME/.zsh/completion)
export EDITOR=/usr/bin/vim
export GREP_COLOR=31
export PATH=$HOME/bin:$HOME/conf/dm/bin:$PATH


###############################################################################
#
# LIBRARIES
#
###############################################################################

# Git functions
source $HOME/.zsh/lib/git.zsh
# Goto funttions
source $HOME/.zsh/lib/goto.zsh
# Jira functions
source $HOME/.zsh/lib/jira.zsh


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
zstyle ':completion:*' use-cache off
#zstyle ':completion:*' cache-path ~/.zsh_cache

unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end


# Ignore completion functions for commands you don’t have.
zstyle ':completion:*:functions' ignored-patterns '_*'

# Autocompletion menu
zstyle ':completion:*' menu select=2


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
# KEY BINDINGS
#
###############################################################################

bindkey -v

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# setup key accordingly
[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-beginning-search
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-beginning-search
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^R' history-incremental-pattern-search-backward

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here.
#export WORDCHARS='*?_[]~=&;!#$%^(){}'

bindkey -M viins '^[[1;5D' vi-backward-word
bindkey -M vicmd '^[[1;5D' vi-backward-word
bindkey -M viins '^[[1;5C' vi-forward-word
bindkey -M vicmd '^[[1;5C' vi-forward-word

# make zsh/terminfo work for terms with application and cursor modes
case "$TERM" in
    xterm*)
        zle-line-init() { echoti smkx }
        zle-line-finish() { echoti rmkx }
        zle -N zle-line-init
        zle -N zle-line-finish
    ;;
esac


###############################################################################
#
# HISTORY
#
###############################################################################

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history
setopt inc_append_history
setopt extended_history
setopt share_history


###############################################################################
#
# AUTO CORRETION
#
###############################################################################

unsetopt correctall


###############################################################################
#
# PROMPT
#
###############################################################################

# Promt sessings.

case $TERM in
	xterm*|urxvt*|rxvt-unicode*|screen)
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
alias t='task'
alias tl='task long'
alias tc='task calendar'
alias less='less -r'
alias tmux='TERM=screen-256color tmux -2'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vmie7='rdesktop -g 1280x800 vmie7.corp.dailymotion.com -d daily -u c.simon'
alias vmie9='rdesktop -g 1280x800 vmie9.corp.dailymotion.com -d daily -u c.simon'

export MYSALT_LOCAL_USER=$LOGNAME
export MYSALT_REMOTE_USER=chriss
export MYSALT_SAFE=1


###############################################################################
#
# FUNCTIONS
#
###############################################################################

function astreinte {
	BASE_PATH="$HOME/Dropbox/Documents/Astreintes"
	FILENAME="$BASE_PATH/Astreintes $(date +%Y-%m).ods"
	TEMPLATE="$BASE_PATH/Astreintes Template.ods"

	if [ ! -f $FILENAME ]; then
		cp "$TEMPLATE" "$FILENAME"
	fi
	libreoffice --calc "$FILENAME"
}
