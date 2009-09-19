# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author of hook: locale-purge
# --------------------------
# creidiki

NEED_PALUDIS="0.26_alpha13"

inherit paludis-hooks

DESCRIPTION="Purge locales automatically."

KEYWORDS="~amd64 ~x86 ~sparc"

DEPEND="app-admin/localepurge"

src_install() {
  	dohook locale-purge.hook auto
}
