EAPI=8

DESCRIPTION="Select a pass entry with dmenu and copy it to the clipboard"
HOMEPAGE="https://git.sr.ht/~merzougao/pass-to-clipboard"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	app-admin/pass
	sys-apps/fd
	x11-misc/dmenu
	x11-misc/xclip
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/pass-to-clipboard/pass-to-clipboard.sh pass-to-clipboard
	doman "${FILESDIR}"/pass-to-clipboard/pass-to-clipboard.1
}
