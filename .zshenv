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
export ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
