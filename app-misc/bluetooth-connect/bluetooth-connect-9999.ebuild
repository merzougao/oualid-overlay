EAPI=8

inherit git-r3

DESCRIPTION="Connect to a bluetooth device"
HOMEPAGE="https://git.sr.ht/~merzougao/bluetooth-connect"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/bluetooth-connect"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	net-wireless/bluez
	x11-apps/xsetroot
	x11-misc/dmenu
"

src_install() {
	newbin bluetooth-connect.sh bluetooth-connect
}
