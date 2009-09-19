# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Hook management wih eselect - for Paludis."

#SRC_URI=""
SRC_URI="mirror://paludis-extras/${P}.tar.bz2 mirror://niki/${P}.tar.bz2 mirror://zxy/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86 ~sparc ~hppa ~x86-fbsd"

DEPEND="sys-apps/paludis
	app-admin/eselect"

RDEPEND="${DEPEND}"
PDEPEND="app-paludis/demo-hooks-definitions"

src_install() {
	dodir /usr/share/eselect/modules/ || die
	insinto /usr/share/eselect/modules/ || die
	newins paludis-hook.eselect paludis-hook.eselect || die

	touch ${WORKDIR}/.keep
	dodir /usr/share/paludis/hooks/eselect/.db/ || die
	insinto /usr/share/paludis/hooks/eselect/.db/ || die
	newins ${WORKDIR}/.keep .keep || die
}
