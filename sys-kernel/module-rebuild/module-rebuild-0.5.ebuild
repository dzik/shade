# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A utility to rebuild any kernel modules which you have installed. Paludis version"
HOMEPAGE="http://drzile.dyndns.org/pe-doc/module-rebuild.php"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="paludis"

DEPEND=""

src_install() {
	if use paludis ; then
		newsbin ${FILESDIR}/${P}-paludis ${PN}
	else
		newsbin ${FILESDIR}/${P} ${PN}
	fi
}

pkg_postinst() {
	if use paludis ; then
		ewarn "-----------------------------------------------------------------"
		ewarn
		ewarn "You chose to install module-rebuild patched for paludis."
		ewarn
		ewarn "When new version (of portage only module-rebuild) comes in the "
		ewarn "gentoo tree, they would be installed during updates, until the"
		ewarn "patched version becomes available in paludis-extras overlay."
		ewarn "The patched version should be available soon."
		ewarn
		ewarn "To avoid this possible problem, put the following into the "
		ewarn "/etc/paludis/package_mask.conf"
		ewarn
		ewarn ">=sys-kernel/module-rebuild-0.5::gentoo"
		ewarn
		ewarn "-----------------------------------------------------------------"
	fi
}
