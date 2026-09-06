EAPI=8

inherit git-r3

DESCRIPTION="Open a link or a bookmark in the browser"
HOMEPAGE="https://git.sr.ht/~merzougao/web-launch"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/web-launch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-misc/jq
	x11-misc/dmenu
"

src_install() {
	newbin web-launch.sh web-launch
}
