EAPI=8

inherit git-r3

DESCRIPTION="Open an instance of tabbed terminal st"
HOMEPAGE="https://git.sr.ht/~merzougao/st-tabbed"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/st-tabbed"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-terms/st
	x11-misc/tabbed
"

src_install() {
	newbin st-tabbed.sh st-tabbed
}
