# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils paludis-hooks

DESCRIPTION="Wrapper script for paludis, that adds new command line options."

KEYWORDS="~amd64 ~x86 ~sparc ~hppa ~x86-fbsd"

IUSE="paludis_hooks_ask paludis_hooks_nice"

src_install() {
	for p in ${IUSE};do
		if use ${p}; then
			p=`echo ${p} | sed 's:paludis_hooks_\(.*\):PALUDIS_WRAPPER_\U\1:'`
			# enabling this option in the wrapper script
			sed s:^${p}=\"no\"$:${p}=\"yes\": -i _paludis_wrapper.bash
		fi
	done

	##
	# Restoring user settings
	####
	if [ -f ${ROOT}/etc/paludis/hooks/config/paludis-nice.conf ]; then
		source ${ROOT}/etc/paludis/hooks/config/paludis-nice.conf
		if [ "x${PALUDIS_NICE}" != "x" ]; then
			if [ ${PALUDIS_NICE} -ge -20 -a ${PALUDIS_NICE} -le 19 -a ${PALUDIS_NICE} -ne 10 ]; then
				sed s/PALUDIS_NICE=.*$/PALUDIS_NICE=${PALUDIS_NICE}/ -i paludis-wrapper.conf
			fi
		fi
	fi

	if [ -f ${ROOT}/etc/paludis/hooks/config/paludis-ask.conf ]; then
		source ${ROOT}/etc/paludis/hooks/config/paludis-ask.conf
		echo ${PALUDIS_HOOKS_ASK_DEFAULT}
		if [ "x${PALUDIS_HOOKS_ASK_DEFAULT}" != "x" ]; then
			if [ "${PALUDIS_HOOKS_ASK_DEFAULT}" == "no" ]; then
				sed s/.*PALUDIS_HOOKS_ASK_DEFAULT=.*$/PALUDIS_HOOKS_ASK_DEFAULT=${PALUDIS_HOOKS_ASK_DEFAULT}/ -i paludis-wrapper.conf
			fi
		fi
		if [ "x${PALUDIS_HOOKS_ASK_WAIT}" != "x" ]; then
			if [ ${PALUDIS_HOOKS_ASK_WAIT} -ne 0 ]; then
				sed s/.*PALUDIS_HOOKS_ASK_WAIT=.*$/PALUDIS_HOOKS_ASK_WAIT=${PALUDIS_HOOKS_ASK_WAIT}/ -i ${P}/paludis-wrapper.conf
			fi
		fi
	fi

	dodir /etc/paludis/hooks/config	
	insinto /etc/paludis/hooks/config || die "insinto failed"
	doins paludis-wrapper.conf || die "doins failed"
	
	exeinto /usr/bin/ || die
	doexe _paludis_wrapper.bash || die
}

pkg_postinst() {
	ewarn "To start using the wrapper, create an alias in the shell"
	ewarn
	ewarn "Shell command: # alias paludis=\"/usr/bin/_paludis_wrapper.bash\""
	ewarn
	ewarn "To make it permanent put it in a .bashrc file in your /root folder"
}

pkg_prerm() {
	true
}
pkg_postrm() {

	ewarn 
	ewarn "If you want to permanently remove ${PN} from your system"
	ewarn "you should manually remove the alias for paludis from /root/.bashrc"
	ewarn "followed by running: unalias paludis"
	ewarn
}
