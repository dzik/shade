# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/l10n-kde4/pl/messages/extragear-multimedia"

inherit subversion

DESCRIPTION="k3b internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND=">=sys-devel/gettext-0.17"
RDEPEND=""

SLOT="4"
KEYWORDS=""
IUSE=""

src_compile() {
	for i in k3b; do
	    msgfmt $i.po -o $i.mo
	done
}

src_install() {
	insinto /usr/share/locale/pl/LC_MESSAGES
	doins *.mo || die
}
