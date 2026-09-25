EAPI=8

inherit git-r3

DESCRIPTION="Fuzzy finder for kakoune using dmenu"
HOMEPAGE="https://git.sr.ht/~merzougao/kakoune-misc"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/kakoune-misc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/dmenu
	sys-apps/fd
	app-editors/kakoune
"

src_install() {
	newbin kakoune-fuzzy.sh kakoune-fuzzy
}
