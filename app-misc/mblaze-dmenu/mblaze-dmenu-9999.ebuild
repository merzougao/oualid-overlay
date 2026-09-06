EAPI=8

inherit git-r3

DESCRIPTION="Utility to handle emails interactively using mblaze and dmenu"
HOMEPAGE="https://git.sr.ht/~merzougao/mblaze-dmenu"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/mblaze-dmenu"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-misc/mblaze-draft
	mail-client/mblaze
	net-mail/isync
	x11-misc/dmenu
"

src_install() {
	newbin mblaze-dmenu.sh mblaze-dmenu
}
