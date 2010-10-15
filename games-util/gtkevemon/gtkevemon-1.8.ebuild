# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GtkEveMon is a skill monitoring stand-alone application for GNU/Linux systems"
HOMEPAGE="http://gtkevemon.battleclinic.com"
SRC_URI="http://gtkevemon.battleclinic.com/releases/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.12
	>=dev-libs/libxml2-2.6.27"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe src/${PN} || die "doexe failed"
	newicon icon/${PN}.xpm ${PN}.xpm
	make_desktop_entry ${PN} "GtkEveMon" ${PN} "Application;Network;GTK"
}
