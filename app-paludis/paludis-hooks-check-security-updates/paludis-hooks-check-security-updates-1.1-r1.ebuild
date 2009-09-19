# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author of hook: check-security-updates
# --------------------------------------

# Author of this ebuild:
# ----------------------
# zxy, truc, dleverton

inherit eutils paludis-hooks

DESCRIPTION="Hook check-security-updates shows GLSA info after syncing with Paludis."

KEYWORDS="~amd64 ~x86 ~sparc"

src_install() {
	dohook check-security-updates-${PV}/check-security-updates.bash sync_all_post
}
