# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils paludis-hooks

DESCRIPTION="Simply adding patches to packages, without editing ebuilds."

KEYWORDS="~amd64 ~x86"

DEPEND="${DEPEND}"

RDEPEND="${DEPEND}"

src_install() {
	dohook auto-patch.bash ebuild_unpack_post install_all_post

	dodir /etc/paludis/hooks/config
	insinto /etc/paludis/hooks/config
	doins auto-patch.conf
}

pkg_postinst() {
	install_hook_using_eselect

	ewarn "You have chosen to install a hook: auto-patch"
	ewarn
	ewarn "WARNING: This hook will try to apply patches you select (or forget)"
	ewarn "WARNING: Before filing a bug, remove all patches, reinstall, and try again..."
	ewarn
	ewarn "WARNING: Anyway be carefull ... this could kill your kitten ..."
}

