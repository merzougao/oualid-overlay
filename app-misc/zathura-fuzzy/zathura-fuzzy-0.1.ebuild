EAPI=8
 
DESCRIPTION="Fuzzy finder for zathura using dmenu"
HOMEPAGE="https://github.com/merzougao/oualid-overlay"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
 
DEPEND="dmenu"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
  dobin zathura-fuzzy.sh
}
