#!/bin/bash

fflag=
while getopts f opt; do
	case $opt in
		f) fflag=1 ;;
	esac
done
shift $((OPTIND - 1))

DF_WD="$HOME/dotfiles"
DH_TARGETS_DIR="$DF_WD/dollarhome"
DC_TARGETS_DIR="$DF_WD/dotconfig"
DH_LINKS_DIR="$HOME"
DC_LINKS_DIR=${XDG_CONFIG_HOME:-"$HOME/.config"}

askforce=

for f in $(ls "$DH_TARGETS_DIR") ; do
	TARGET="$DH_TARGETS_DIR/$f"
	LINK_NAME="$DH_LINKS_DIR/.$f" # NB! Dot in front of $f
	if [[ -f "$LINK_NAME" ]] ; then
		if [[ -z $fflag ]] ; then
			echo "Error: Dotfile already exists: .$f" >&2
			askforce=1
			continue
		else
			rm -v "$LINK_NAME"
		fi
	fi
	ln -sv "$TARGET" "$LINK_NAME"
done

[[ ! -d $DC_LINKS_DIR ]] && mkdir -v $DC_LINKS_DIR

for d in $(ls "$DC_TARGETS_DIR") ; do
	TARGET="$DC_TARGETS_DIR/$d"
	LINK_NAME="$DC_LINKS_DIR/$d"
	if [[ -d "$LINK_NAME" ]] ; then
		if [[ -z $fflag ]] ; then
			echo "Error: Directory already exists: $d" >&2
			askforce=1
			continue
		else
			# Not gonna use -f flag as there shouldn't be any
			# protected files/directories
			rm -rv "$LINK_NAME"
		fi
	fi
	ln -sv "$TARGET" "$LINK_NAME"
done

[[ -n $askforce ]] && echo "Use -f flag to force overwrite" >&2
