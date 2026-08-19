EAPI=8

DESCRIPTION="Utility to handle emails interactively using mblaze and dmenu"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	=mail-client/mblaze-9999
	=app-misc/pinentry-dmenu-0.1
	x11-misc/dmenu
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/mblaze-dmenu.sh mblaze-dmenu
}
