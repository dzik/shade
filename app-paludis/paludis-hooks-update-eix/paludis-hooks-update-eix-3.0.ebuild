# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PALUDIS="0.26_alpha13"

inherit eutils paludis-hooks
SRC_URI="http://prophet.ath.cx:8080/~shade/packages/paludis-hooks-update-eix-${MY_PV}.tar.bz2"


DESCRIPTION="Hook update-eix makes eix work with Paludis."

KEYWORDS="~amd64 ~x86 ~sparc ~x86-fbsd"

DEPEND=">=app-portage/eix-0.17.0"

RDEPEND="${DEPEND}"


src_install() {
        epatch "${FILESDIR}/${P}-fix-name.patch"

        dodir /etc/paludis/hooks/config
        insinto /etc/paludis/hooks/config || die "update-eix.conf: insinto failed"
        doins update-eix.conf || die "update-eix.conf: doins failed"

        dohook update-eix.hook auto
}

