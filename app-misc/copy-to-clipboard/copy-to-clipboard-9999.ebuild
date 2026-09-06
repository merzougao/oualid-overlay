EAPI=8

inherit git-r3

DESCRIPTION="Copy the filepath selected through dmenu to the clipboard"
HOMEPAGE="https://git.sr.ht/~merzougao/copy-to-clipboard"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/copy-to-clipboard"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	sys-apps/fd
	x11-misc/dmenu
	x11-misc/xclip
"

src_install() {
	newbin copy-to-clipboard.sh copy-to-clipboard
}
