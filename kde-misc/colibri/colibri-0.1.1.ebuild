# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base


DESCRIPTION="KDE4 plasma notifer."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=117147"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/117147-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
		>=kde-base/plasma-workspace-${KDE_MINIMAL}
		>=kde-base/kdelibs-4.4.0
"
