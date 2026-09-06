EAPI=8

inherit git-r3

DESCRIPTION="Open dmenu_run with a custom list of program/scripts"
HOMEPAGE="https://git.sr.ht/~merzougao/dmenu-launch"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/dmenu-launch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/dmenu
"

src_install() {
	newbin dmenu-launch.sh dmenu-launch
}
