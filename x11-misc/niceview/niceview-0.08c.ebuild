# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4

MY_P="${P}-source"

DESCRIPTION="Simple slideshow program for displaying naked women"
HOMEPAGE="http://sourceforge.net/projects/niceview/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( =x11-libs/qt-4.3*:4
		x11-libs/qt-gui )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}/${PN}.pro.patch" )

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake failed"
	dodoc doc/CHANGELOG || die "dodoc failed"
}
