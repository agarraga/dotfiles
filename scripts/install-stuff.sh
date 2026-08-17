#!/bin/bash

fflag=
while getopts f opt; do
	case $opt in
		f) fflag=1 ;;
	esac
done
shift $((OPTIND - 1))

if [[ -n $fflag ]] ; then
	PACKAGES=$(<"$1")
else
	PACKAGES=$@
fi

# Global Vars
main () {
    determine_package_manager
    install_from_list ${PACKAGES[@]}
}

install_from_list() {
    a=("$@")
    for app in ${a[@]}; do
        if ${install} $app ; then
            echo "Package installed: $app"
        else
            echo "Error: Could not install package: $app" >&2
        fi
    done
}

determine_package_manager() {
    if [ -x "$(command -v apt-get)" ]; then
        apt-get -y update && apt-get -y upgrade
        install="apt-get install -y"
        echo "Using apt-get to install packages"
    elif [ -x "$(command -v yum)" ]; then
        yum -y update
        install="yum install -y"
        echo "Using Yellow Dog Updater, Modified to install packages"
    elif [ -x "$(command -v dnf)" ]; then
        dnf -y update
        install="dnf install -y"
        echo "Using Dandified YUM to install packages"
    elif [ "$(command -v pacman)" ]; then
        pacman -Syu
        install="pacman -S --noconfirm"
        echo "Using pacman to install packages"
    elif [ "$(command -v zypper)" ]; then
        zypper update
        install="zypper install -y"
        echo "Using zypper to install packages"
    else
        echo "Error: Executable package manager not found." >&2
	echo "Update the script or install one of the available managers:" >&2
	echo "apt, yum, dnf, pacman, zypper" >&2
        exit $ERRCODE
    fi
}

main
