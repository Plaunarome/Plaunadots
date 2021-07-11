Plaunadots
===

Welcome! These are Plaunarome's user configuration files for their [Arch Linux](https://archlinux.org) system.

This repository is available online on [GitHub](https://github.com/Plaunarome/Plaunadots) and on [GitLab](https://gitlab.com/Plaunarome/Plaunadots).

Contents
---

1. [Overview](#overview)
	1. [Configured programs](#configured-programs)
	2. [suckless software](#suckless-software)
	3. [XDG workarounds](#xdg-workarounds)
2. [Installation](#installation)
3. [License](#license)

Overview
---

### Configured programs

The following programs have been provided configuration files in this repository:

* calcurse: calendar and to-do list
* Dunst: notification daemon
* ECWolf: advanced source port for Wolfenstein 3D engine games
* Fontconfig: font configuration library
* Git: version control system
* GTK 2/3: GUI toolkit
* makepkg: package building utility
* MPD: music player daemon
* Paru: AUR helper
* picom: compositor
* startx: xinit wrapper
* xdg-user-dirs: user directory manager
* xdg-utils: desktop integration utilities
* xinit: Xorg initializer
* zathura: document viewer
* Zsh: shell

### suckless software

The following forks of [suckless](https://suckless.org) software are being used:

* dmenu: *Coming soon...* <!-- FIXME: Add links -->
* dwm: *Coming soon...* <!-- FIXME: Add links -->
* slock: *Coming soon...* <!-- FIXME: Add links -->
* st: *Coming soon...* <!-- FIXME: Add links -->

### XDG workarounds

The following workarounds are being used to force programs to keep their files in the XDG directories:

* GTK 2: `$GTK2_RC_FILES` is set and imported into the systemd user environment
* MPD: `$MPD_HOST` is set and other files are stored in `${XDG_DATA_HOME}/mpd`
* pass: `$PASSWORD_STORE_DIR` is set
* startx: use `startx "$XINITRC"` instead
* xinit: `$XINITRC` is set
* Zsh: `$ZDOTDIR` is set

Installation
---

*Coming soon...* <!-- FIXME: Add instructions -->

License
---

Plaunadots is distributed under the terms of the GNU General Public License, version 3 or later. See the [COPYING](COPYING) file for details.
