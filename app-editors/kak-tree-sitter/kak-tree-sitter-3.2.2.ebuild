# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.4
	allocator-api2@0.2.21
	android_system_properties@0.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.102
	arc-swap@1.9.1
	autocfg@1.5.0
	bitflags@2.11.0
	block2@0.6.2
	bumpalo@3.20.2
	cc@1.2.60
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	chrono@0.4.44
	clap@4.6.0
	clap_builder@4.6.0
	clap_derive@4.6.0
	clap_lex@1.1.0
	colorchoice@1.0.5
	colored@3.1.1
	core-foundation-sys@0.8.7
	ctrlc@3.5.2
	daemonize@0.5.0
	deranged@0.5.8
	diff@0.1.13
	dirs-sys@0.5.0
	dirs@6.0.0
	dispatch2@0.3.1
	equivalent@1.0.2
	find-msvc-tools@0.1.9
	foldhash@0.1.5
	getrandom@0.2.17
	getrandom@0.4.2
	hashbrown@0.15.5
	hashbrown@0.17.0
	heck@0.5.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.65
	id-arena@2.3.0
	indexmap@2.14.0
	is_terminal_polyfill@1.70.2
	itoa@1.0.18
	js-sys@0.3.95
	kstring@2.0.2
	leb128fmt@0.1.0
	libc@0.2.185
	libloading@0.8.9
	libredox@0.1.16
	log@0.4.29
	memchr@2.8.0
	mio@1.2.0
	nix@0.31.2
	num-conv@0.2.1
	num-traits@0.2.19
	num_threads@0.1.7
	objc2-encode@4.1.0
	objc2@0.6.4
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	option-ext@0.2.0
	powerfmt@0.2.0
	pretty_assertions@1.4.1
	prettyplease@0.2.37
	proc-macro2@1.0.106
	quote@1.0.45
	r-efi@6.0.0
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-cursor@0.1.5
	regex-syntax@0.8.10
	regex@1.12.3
	ropey@1.6.1
	rustversion@1.0.22
	semver@1.0.28
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_spanned@1.1.1
	shlex@1.3.0
	simple_logger@5.2.0
	slab@0.4.12
	smallvec@1.15.1
	static_assertions@1.1.0
	str_indices@0.4.4
	strsim@0.11.1
	syn@2.0.117
	thiserror-impl@2.0.18
	thiserror@2.0.18
	time-core@0.1.8
	time-macros@0.2.27
	time@0.3.47
	toml@0.9.12+spec-1.1.0
	toml_datetime@0.7.5+spec-1.1.0
	toml_parser@1.1.2+spec-1.1.0
	toml_writer@1.1.1+spec-1.1.0
	tree-house-bindings@0.2.3
	tree-house@0.3.0
	tree-sitter-language@0.1.7
	tree-sitter-rust@0.24.2
	unicode-ident@1.0.24
	unicode-segmentation@1.13.2
	unicode-width@0.1.12
	unicode-xid@0.2.6
	utf8parse@0.2.2
	uuid@1.23.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-macro-support@0.2.118
	wasm-bindgen-macro@0.2.118
	wasm-bindgen-shared@0.2.118
	wasm-bindgen@0.2.118
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	windows-core@0.62.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.61.2
	winnow@0.7.15
	winnow@1.0.1
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	yansi@1.0.1
	zmij@1.0.21
"

RUST_MIN_VER="1.88.0"

inherit cargo

MY_TAG="${PN}-v${PV}"

DESCRIPTION="Tree-sitter integration (server + ktsctl controller) for the Kakoune editor"
HOMEPAGE="https://sr.ht/~hadronized/kak-tree-sitter/"
SRC_URI="
	https://git.sr.ht/~hadronized/kak-tree-sitter/archive/${MY_TAG}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${MY_TAG}"

LICENSE="BSD"
# Dependent crate licenses
LICENSE+=" Apache-2.0 ISC MIT MPL-2.0 Unicode-3.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# ktsctl shells out to git(1) at runtime to fetch grammars/queries; a C
# compiler (provided by @system) is used to build the grammars.
RDEPEND="dev-vcs/git"

src_install() {
	cargo_src_install --path kak-tree-sitter
	cargo_src_install --path ktsctl

	dodoc README.md CHANGELOG.md
	docinto config
	dodoc kak-tree-sitter-config/default-config.toml

	# Upstream's bundled tree-sitter queries (reference; ktsctl normally
	# installs grammars/queries into ${XDG_DATA_HOME}/kak-tree-sitter).
	insinto /usr/share/${PN}
	doins -r runtime
}
