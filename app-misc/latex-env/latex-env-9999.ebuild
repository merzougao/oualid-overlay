EAPI=8

inherit git-r3

DESCRIPTION="Open a TeX file in kakoune and track its compilation"
HOMEPAGE="https://git.sr.ht/~merzougao/latex-env"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/latex-env"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-admin/entr
	app-editors/kakoune
	dev-texlive/texlive-latex
	sys-apps/fd
	x11-misc/dmenu
	x11-misc/tabbed
	x11-terms/st
"

src_install() {
	newbin latex-env.sh latex-env
	doman latex-env.1
}
