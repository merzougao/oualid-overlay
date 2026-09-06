EAPI=8

inherit git-r3

DESCRIPTION="Utility to handle drafts using mblaze and dmenu"
HOMEPAGE="https://git.sr.ht/~merzougao/mblaze-draft"
EGIT_REPO_URI="https://git.sr.ht/~merzougao/mblaze-draft"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	mail-client/mblaze
	sys-apps/fd
	x11-misc/dmenu
"

src_install() {
	newbin mblaze-draft.sh mblaze-draft
	doman mblaze-draft.1
}
