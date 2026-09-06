EAPI=8

inherit git-r3

DESCRIPTION="Select a pass entry with dmenu and copy it to the clipboard"
HOMEPAGE="https://git.sr.ht/~merzougao/pass-to-clipboard"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/pass-to-clipboard"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-admin/pass
	sys-apps/fd
	x11-misc/dmenu
	x11-misc/xclip
"

src_install() {
	newbin pass-to-clipboard.sh pass-to-clipboard
	doman pass-to-clipboard.1
}
