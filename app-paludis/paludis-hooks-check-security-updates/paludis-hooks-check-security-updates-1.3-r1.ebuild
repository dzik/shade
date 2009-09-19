# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author of hook: check-security-updates
# --------------------------------------
# updated by creidiki

# Author of this ebuild:
# ----------------------
# zxy, truc, dleverton

NEED_PALUDIS="0.26_alpha13"

inherit eutils paludis-hooks

DESCRIPTION="Hook check-security-updates shows GLSA info after syncing with Paludis."

KEYWORDS="~amd64 ~x86 ~sparc"

src_install() {
	epatch "${FILESDIR}"/1.3-no-false-error.diff || die
	dohook check-security-updates.hook auto
}
