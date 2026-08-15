EAPI=8

DESCRIPTION="mblaze utilities"
HOMEPAGE="https://github.com/leahneukirchen/mblaze"
EGIT_REPO_URI="https://github.com/leahneukirchen/mblaze"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

inherit git-r3

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
