EAPI=8

DESCRIPTION="Utility to handle drafts using mblaze and dmenu"
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
	newbin "${FILESDIR}"/mblaze-draft.sh mblaze-draft
	doman "${FILESDIR}"/mblaze-draft.1
}
