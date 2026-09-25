EAPI=8

inherit git-r3

DESCRIPTION="Small wrapper around opening files in the current window"
HOMEPAGE="https://git.sr.ht/~merzougao/open-here"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/open-here"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-misc/zathura-fuzzy
	app-misc/kakoune-fuzzy
	x11-misc/xdotool
"

src_install() {
	newbin open-here.sh open-here
}
