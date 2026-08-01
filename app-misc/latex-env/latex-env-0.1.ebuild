EAPI=8

DESCRIPTION="Open a TeX file in kakoune and use entr to track compilation"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	app-editors/kakoune
	app-admin/entr
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/latex-env.sh latex-env
}
