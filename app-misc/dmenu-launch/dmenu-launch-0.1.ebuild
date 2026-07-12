EAPI=8

DESCRIPTION="Open dmenu_run with a custom list of program/scripts"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-misc/dmenu
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/dmenu-launch.sh dmenu-launch
}
