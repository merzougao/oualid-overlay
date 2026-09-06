EAPI=8

inherit git-r3

DESCRIPTION="Open a file in kakoune"
HOMEPAGE="https://git.sr.ht/~merzougao/kakoune-open"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/kakoune-open"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-editors/kakoune
	sys-apps/fd
	x11-misc/dmenu
	x11-terms/st
"

src_install() {
	newbin kakoune-open.sh kakoune-open
}
