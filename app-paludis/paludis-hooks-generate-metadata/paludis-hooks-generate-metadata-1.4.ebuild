# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author of hook: creidiki

NEED_PALUDIS="0.26_alpha13"

inherit paludis-hooks

DESCRIPTION="Keep your metadata up to date with incremental (and fast) instruo runs."

KEYWORDS="~amd64 ~x86 ~sparc ~x86-fbsd"

RDEPEND=">=app-portage/portage-utils-20070504-r1"

src_install() {
	dohook generate-metadata.hook auto

	dodir /etc/paludis/hooks/config
	insinto /etc/paludis/hooks/config || die "generate-metadata.conf: insinto failed"
	doins generate-metadata.conf || die "generate-metadata.conf: doins failed"
}
