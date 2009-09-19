# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PALUDIS="0.26_alpha13"

inherit paludis-hooks

DESCRIPTION="Creates the the resume file before each package installation, making it proof against hard locks and power failures."

KEYWORDS="~amd64 ~x86"

src_install() {
	dohook package-resume.hook auto
}
