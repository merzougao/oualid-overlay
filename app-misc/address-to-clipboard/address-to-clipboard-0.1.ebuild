EAPI=8

DESCRIPTION="Address book utilities"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-misc/xclip
	x11-misc/dmenu
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/address-to-clipboard.sh address-to-clipboard
}
