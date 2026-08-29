# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Neatroff typesetter with PostScript and PDF output"
HOMEPAGE="
	https://github.com/aligrudi/neatroff
	https://github.com/aligrudi/neatroff_make
"
EGIT_REPO_URI="https://github.com/aligrudi/neatroff_make.git"

LICENSE="ISC MIT"
SLOT="0"

BDEPEND="media-fonts/urw-fonts"
RDEPEND="media-fonts/urw-fonts"

src_unpack() {
	local repo
	for repo in neatroff neatpost neatmkfn neateqn; do
		EGIT_REPO_URI="https://github.com/aligrudi/${repo}.git" \
			EGIT_CHECKOUT_DIR="${WORKDIR}/${repo}" git-r3_src_unpack
	done

	EGIT_REPO_URI="https://github.com/aligrudi/neatroff_make.git" \
		EGIT_CHECKOUT_DIR="${S}" git-r3_src_unpack

	for repo in neatroff neatpost neatmkfn neateqn; do
		mv "${WORKDIR}/${repo}" "${S}/${repo}" || die
	done
}

src_compile() {
	local cflags="${CPPFLAGS} ${CFLAGS}"
	local fdir="${EPREFIX}/usr/share/neatroff/font"
	local mdir="${EPREFIX}/usr/share/neatroff/tmac"
	local build_fontdir="${BROOT}/usr/share/fonts/urw-fonts"
	local runtime_fontdir="${EPREFIX}/usr/share/fonts/urw-fonts"

	emake -C neatmkfn \
		CC="$(tc-getCC)" CFLAGS="${cflags}" LDFLAGS="${LDFLAGS}"
	emake -C neatroff \
		CC="$(tc-getCC)" \
		CFLAGS="${cflags} -DTROFFFDIR=\\\"${fdir}\\\" -DTROFFMDIR=\\\"${mdir}\\\"" \
		LDFLAGS="${LDFLAGS}"
	emake -C neatpost \
		CC="$(tc-getCC)" \
		CFLAGS="${cflags} -DTROFFFDIR=\\\"${fdir}\\\"" \
		LDFLAGS="${LDFLAGS}"
	emake -C neateqn \
		CC="$(tc-getCC)" \
		CFLAGS="${cflags} -DTROFFFDIR=\\\"${fdir}\\\"" \
		LDFLAGS="${LDFLAGS}"

	(
		cd neatmkfn || die
		MKFN_RES=7200 ./gen.sh "${build_fontdir}" "${S}/devutf" >/dev/null
	) || die "failed to generate font descriptions"

	sed -i \
		-e "s|^fontpath ${build_fontdir}/|fontpath ${runtime_fontdir}/|" \
		devutf/* || die
}

src_install() {
	newbin neatroff/roff neatroff
	newbin neatpost/post neatpost
	newbin neatpost/pdf neatpdf
	newbin neateqn/eqn neateqn

	doman man/{neatroff,neatpost,neateqn}.1

	insinto /usr/share/neatroff/tmac
	doins -r tmac/*
	insinto /usr/share/neatroff/font/devutf
	doins devutf/*

	dodoc README
	newdoc tmac/NOTICE tmac-NOTICE
}
