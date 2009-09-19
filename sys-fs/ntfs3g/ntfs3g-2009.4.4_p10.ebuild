# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

MY_PN="${PN/3g/-3g}"
MY_P="${MY_PN}-${PV/_p/AR.}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.ntfs-3g.org"
SRC_URI="http://pagesperso-orange.fr/b.andre/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug hal suid"

RDEPEND="hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-ldscript \
		--disable-ldconfig \
		$(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	prepalldocs
	dodoc AUTHORS ChangeLog CREDITS

	use suid && fperms u+s "/bin/${MY_PN}"

	if use hal; then
		insinto /etc/hal/fdi/policy/
		newins "${FILESDIR}/10-ntfs3g.fdi.2009" "10-ntfs3g.fdi"
	fi
}

pkg_postinst() {
	ewarn
	ewarn "This is an advanced features release of the ntfs-3g package. It"
	ewarn "passes standard tests on i386 and x86_64 CPUs but users should"
	ewarn "still backup their data.  More info at:"
	ewarn "http://pagesperso-orange.fr/b.andre/advanced-ntfs-3g.html"
	ewarn
	
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}