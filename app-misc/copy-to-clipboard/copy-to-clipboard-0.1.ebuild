EAPI=8

DESCRIPTION="Copy the filepath selected through dmenu to the clipboard"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-misc/dmenu
	x11-misc/xclip
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/copy-to-clipboard.sh copy-to-clipboard
}
