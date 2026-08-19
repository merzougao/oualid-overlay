EAPI=8

DESCRIPTION="A dmenu interface for pinentry"
HOMEPAGE="https://github.com/mrdotx/pinentry-dmenu"
EGIT_REPO_URI="https://github.com/mrdotx/pinentry-dmenu"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

inherit git-r3

PATCHES=( "${FILESDIR}/01-short-description.patch" )

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
