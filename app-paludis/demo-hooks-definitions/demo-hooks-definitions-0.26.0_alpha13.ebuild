# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PALUDIS="0.26_alpha13"

inherit eutils

DESCRIPTION="Definitions for eselect paludis-hook for Paludis's demo hooks."

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86 ~sparc ~hppa ~x86-fbsd"

DEPEND="sys-apps/paludis
	>=app-admin/eselect-paludis-hooks-0.3.0"

RDEPEND="${DEPEND}"

src_install() {
#	touch ${WORKDIR}/.keep
#	dodir /usr/share/paludis/hooks/eselect/.db/ || die
#	insinto /usr/share/paludis/hooks/eselect/.db/ || die
#	newins ${WORKDIR}/.keep .keep || die

	for i in `ls .` ; do
		insinto /usr/share/paludis/hooks/eselect/ || die
		newins ${i} ${i} || die
	done
}
