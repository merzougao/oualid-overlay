EAPI=8

DESCRIPTION="Connect to a bluetooth device"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}"/bluetooth-connect.sh bluetooth-connect
}
