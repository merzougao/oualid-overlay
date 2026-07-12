EAPI=8

DESCRIPTION="Open a file in kakoune"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	app-editors/kakoune
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/kakoune-open.sh kakoune-open
}
