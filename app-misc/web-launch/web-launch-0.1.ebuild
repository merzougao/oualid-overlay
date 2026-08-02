EAPI=8

DESCRIPTION="Open a link or a bookmark in the browser"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/web-launch.sh web-launch
}
