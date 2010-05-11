#!/bin/bash
# Copyrigt (c) by Martin Ošmera <martin.osmera@gmail.com>
# Distributed under terms of GNU GPLv2 Licence
# This script is distributed with NO WARRANTY !!!


## VARIABLES

target_directory="/usr/local/portage/dev-embedded/mcu8051ide"
source_ebuild="mcu8051ide-1.3.5.ebuild"
target_ebuild="${source_ebuild}"
package_name="mcu8051ide"


## FUNCTIONS

# Write message and exit the script
failure() {
	echo -ne "\t\033[31mERROR: ${1}\033[30m\n"
	exit
}


## INITIALIZATION

# check if user is root
if [ "$UID" != "0" ]; then
	failure "You must have superuser rights."
fi

# check if the ebuild is avaible
if ! [ -f "${source_ebuild}" ]; then
	failure "Unable to find ${source_ebuild}"
fi


# INSTALATION

echo "Creating target directory..."
mkdir -p ${target_directory} || failure "Unable to create directory: ${target_directory}"

echo "Creating target ebuild ..."
cp "${source_ebuild}" "${target_directory}/${target_ebuild}" >> /dev/null || faulure "Unable to copy source ebuild"

echo "Creating ebuild manifest ..."
ebuild --force "${target_directory}/${target_ebuild}" digest	|| failure "Unable to make ebuild digest"

echo "Modifing /etc/make.conf ..."
if ! [ -f "/etc/make.conf" ]; then
	failure "/etc/make.conf not found"
fi

cp "/etc/make.conf" "/etc/make.conf.old.$(date "+%m%d%H%M%S")"	|| failure "Unable to make backup copy of the make.conf"
make_conf_text=$(cat /etc/make.conf)
echo -nE "$make_conf_text" | awk 'BEGIN {
		contain_PORTDIR_OVERLAY=0
		contain_LOCAL_OVERLAY=0
	}

	END {
		if(!contain_PORTDIR_OVERLAY && !contain_LOCAL_OVERLAY) {
			print "PORTDIR_OVERLAY=\"/usr/local/portage\""
		} else if(contain_PORTDIR_OVERLAY && !contain_LOCAL_OVERLAY) {
			print "PORTDIR_OVERLAY=\"${PORTDIR_OVERLAY} /usr/local/portage\""
		}
	}

	/^PORTDIR_OVERLAY\=/ {
		contain_PORTDIR_OVERLAY=1

		if(match($0, /[^#]*[ \t\n\"]\/usr\/local\/portage[ \t\n\"]/))
			contain_LOCAL_OVERLAY=1
	}

	{
		print $0
	}' > /etc/make.conf || failure "Unable to modify make.conf"


echo -ne "\nEbuild installation successful\n"
echo -ne "\ttype \033[32m emerge -va ${package_name}\033[m to install the software\n\n"

