#!/bin/zsh

# Copyright (C) 2021  Plaunarome
# This file is part of Plaunadots.
#
# Plaunadots is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Plaunadots is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Plaunadots.  If not, see <https://www.gnu.org/licenses/>.

[ -z "$HOME" ] && { >&2 echo "The environment variable \$HOME is required, but it is unset or empty."; exit 1; }
: "${XDG_DATA_HOME:=${HOME}/.local/share}"
mkdir --mode 700 --parents -- "$XDG_DATA_HOME" || exit 1

setopt interactive_comments
stty stop undef

# -- Aliases -- #
alias l="ls -l --almost-all"

alias y="youtube-dl --add-metadata --embed-subs --format 'bestvideo[height<=?1080]+bestaudio/best' --output '%(upload_date)s - %(uploader)s - %(title)s (%(id)s).%(ext)s' --sub-lang en,en-CA,en-GB,en-US --write-auto-sub --write-sub"
alias ya="y --extract-audio"

# --- Default arguments --- #
alias chgrp="chgrp --preserve-root --verbose"
alias chmod="chmod --preserve-root --verbose"
alias chown="chown --preserve-root --verbose"
alias cp="cp --interactive --verbose"
alias df="df --human-readable"
alias diff="diff --color=auto"
alias du="du --human-readable --total"
alias ffmpeg="ffmpeg -hide_banner"
alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias ln="ln --interactive --verbose"
alias ls="ls --classify --color=auto --group-directories-first --human-readable --literal"
alias mkdir="mkdir --parents --verbose"
alias mv="mv --interactive --verbose"
alias rm="rm --verbose" # an alternative to --interactive=once is built into Zsh
alias startx="startx \"\$XINITRC\""

# --- Git --- #
alias g="git"

alias gcl="g clone"
alias gf="g fetch"
alias gg="g grep"
alias ggc="g gc"
alias gi="g init"
alias gl="g log"
alias gmv="g mv"
alias gpl="g pull"
alias gps="g push"
alias grm="g rm"
alias gs="g status"
alias gsh="g show"

alias ga="g add"
alias gap="ga --patch"

alias gc="g commit"
alias gca="gc --amend"
alias gcm="gc --message"

alias gce="g clean -dx --force"
alias gced="gce --dry-run"

alias gch="g checkout"
alias gchb="gch -b"

alias gd="g diff"
alias gdc="gd --cached"

alias gr="g reset"
alias grh="gr --hard"
alias grs="gr --soft"

alias grb="g rebase"
alias grba="grb --abort"
alias grbc="grb --continue"
alias grbi="grb --interactive"

alias grt="g restore"
alias grts="grt --staged"

alias gst="g stash"
alias gstp="gst pop"

# -- Change directories with lf -- #
function lfcd() {
	last_directory_path="$(mktemp --tmpdir zsh-lfcd.XXXXXXXXXX)" || { lfcd_cleanup; return 1; }
	lf --last-dir-path "$last_directory_path" || { lfcd_cleanup; return 1; }
	cd -- "$(< "$last_directory_path")"

	lfcd_cleanup
}

function lfcd_cleanup() {
	zle reset-prompt > /dev/null 2>&1
	\rm "$last_directory_path"
}

zle -N lfcd
bindkey -M vicmd ";" lfcd

# -- Completion -- #
autoload -Uz compinit
compinit

zstyle ":completion:*" menu select
zmodload zsh/complist
bindkey -M menuselect h vi-backward-char
bindkey -M menuselect j vi-down-line-or-history
bindkey -M menuselect k vi-up-line-or-history
bindkey -M menuselect l vi-forward-char

# -- Cursor -- #
cursor_blinking_block=$'\E[1 q'
cursor_blinking_bar=$'\E[5 q'

function zle-keymap-select() {
	[ "$KEYMAP" = "main" ] && echo -n "$cursor_blinking_bar" && return
	echo -n "$cursor_blinking_block"
}

function zle-line-init() {
	echo -n "$cursor_blinking_bar"
}

zle -N zle-keymap-select
zle -N zle-line-init

# -- Edit the command line in the text editor -- #
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd n edit-command-line # FIXME: returns exit code 1?

# -- History -- #
HISTSIZE=10000
SAVEHIST=10000

mkdir --parents -- "${XDG_DATA_HOME}/zsh" || exit 1
HISTFILE="${XDG_DATA_HOME}/zsh/history"

autoload -Uz {down,up}-line-or-beginning-search

zle -N down-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M vicmd j down-line-or-beginning-search
bindkey -M vicmd k up-line-or-beginning-search

# -- less/man colors -- #
export LESS="--RAW-CONTROL-CHARS"

export LESS_TERMCAP_md=$'\E[1;36m' # bold (headers)
export LESS_TERMCAP_so=$'\E[1;7m' # reverse video (prompt, search results)
export LESS_TERMCAP_us=$'\E[33m' # underline

# --- Reset --- #
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'

# -- Prompt -- #
PROMPT="%B%(?..(%?%) )[%n@%M %1~]%(!.#.$)%b "
RPROMPT="%B%/%b"

# -- Syntax highlighting -- #
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# -- vi mode -- #
bindkey -v "^?" backward-delete-char
KEYTIMEOUT=1

bindkey "^[[P" delete-char
bindkey -M vicmd "^[[P" delete-char
