# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils paludis-hooks

DESCRIPTION="Hook ask provides -a, --ask functionality for Paludis."

KEYWORDS="~amd64 ~x86 ~sparc ~hppa ~x86-fbsd"

DEPEND=">=app-paludis/paludis-wrapper-0.1.2_pre1"

RDEPEND="${DEPEND}"

src_install() {
	dohook paludis-ask.bash uninstall_all_pre install_all_pre fetch_all_pre
}

pkg_postinst() {
	install_hook_using_eselect

	ewarn "You have chosen to install a hook: ask"
	ewarn "To start using this hook, create an alias in the shell"
	ewarn
	ewarn "Shell command: # alias paludis=\"/usr/bin/_paludis_wrapper.bash\""
	ewarn
	ewarn "To make it permanent put it in a .bashrc file in your /root folder"

	if use paludis_hooks_eselect ; then
	        ewarn
		ewarn "If you updated to a higher version of the hook,"
		ewarn "you might need to run the following again:"
	        ewarn
		ewarn "# eselect paludis-hook enable ask"
	fi
}

