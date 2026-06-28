EAPI=8

DESCRIPTION="Open an instance of tabbed terminal st"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-terms/st
	x11-misc/tabbed
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/st-tabbed.sh st-tabbed
}
