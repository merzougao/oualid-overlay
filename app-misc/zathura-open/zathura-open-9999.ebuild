EAPI=8

inherit git-r3

DESCRIPTION="Fuzzy finder for zathura using dmenu"
HOMEPAGE="https://git.sr.ht/~merzougao/zathura-misc"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/zathura-misc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/dmenu
	sys-apps/fd
	app-text/zathura
"

src_install() {
	newbin zathura-open.sh zathura-open
}
