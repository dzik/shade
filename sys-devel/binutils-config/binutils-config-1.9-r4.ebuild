# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-config/binutils-config-1.9-r3.ebuild,v 1.1 2006/11/26 13:40:14 vapier Exp $

DESCRIPTION="Utility to change the binutils version being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="paludis"

RDEPEND="userland_GNU? ( >=sys-apps/findutils-4.2 )
paludis? ( sys-apps/paludis )"

src_install() {
	if use paludis ; then
		newbin "${FILESDIR}"/${PN}-${PV}-paludis ${PN} || die
		doman "${FILESDIR}"/${PN}.8-paludis
	else
		newbin "${FILESDIR}"/${PN}-${PV} ${PN} || die
		doman "${FILESDIR}"/${PN}.8
	fi
}

pkg_postinst() {
	if use paludis ; then
		ewarn "-----------------------------------------------------------------"
		ewarn
		ewarn "You chose to install binutils-config patched for paludis."
		ewarn
		ewarn "When new version (of portage only binutils-config) comes in the "
		ewarn "gentoo tree, they will be installed during updates, until the"
		ewarn "patched version becomes available in paludis-extras overlay."
		ewarn "The patched version should be available soon."
		ewarn
		ewarn "To avoid this possible problem, put the following into the "
		ewarn "/etc/paludis/package_mask.conf"
		ewarn
		ewarn "sys-devel/binutils-config::gentoo"
		ewarn
		ewarn "-----------------------------------------------------------------"
	fi
}
