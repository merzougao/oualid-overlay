EAPI=8

DESCRIPTION="Fuzzy finder for zathura using dmenu"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-misc/dmenu
	sys-apps/fd
	app-text/zathura
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/zathura-fuzzy.sh zathura-fuzzy
}
