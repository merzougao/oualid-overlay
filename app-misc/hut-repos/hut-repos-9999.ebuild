EAPI=8

inherit git-r3

DESCRIPTION="Utility to clone on navigate to a sourcehut repo locally"
HOMEPAGE="https://git.sr.ht/~merzougao/hut-repos"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/hut-repos"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/dmenu
	dev-util/hut
"

src_install() {
	newbin hut-repos.sh hut-repos
	doman hut-repos.1
}
