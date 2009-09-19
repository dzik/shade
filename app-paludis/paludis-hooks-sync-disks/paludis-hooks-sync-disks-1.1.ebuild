# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author of hook: sync-disks
# --------------------------
# zxy

inherit paludis-hooks

DESCRIPTION="Hook sync-disks makes a kernel sync call (writes any data buffered in memory out to disk)."

KEYWORDS="~amd64 ~x86 ~sparc"

src_install() {
  	dohook sync-disks.bash uninstall_all_post uninstall_post install_all_post install_post sync_all_post sync_post
}
