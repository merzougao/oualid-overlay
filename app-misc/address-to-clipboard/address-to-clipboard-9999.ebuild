EAPI=8

inherit git-r3

DESCRIPTION="Address book utilities"
HOMEPAGE="https://git.sr.ht/~merzougao/address-to-clipboard"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/address-to-clipboard"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/xclip
	x11-misc/dmenu
"

src_install() {
	newbin address-to-clipboard.sh address-to-clipboard
}
