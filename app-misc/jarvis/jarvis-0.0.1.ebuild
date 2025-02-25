# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="My desktop assistant"
HOMEPAGE="https://github.com/dingjingmaster/data-analysis"
SRC_URI="https://github.com/dingjingmaster/data-analysis/archive/refs/tags/data-analysis-0.0.1.tar.gz
	https://github.com/dingjingmaster/html-parser/archive/refs/tags/html-parser-0.0.1.tar.gz
	https://github.com/dingjingmaster/macros/archive/refs/tags/macros-0.0.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

export BASEDIR="`pwd`/.."
export WORKDIR="${BASEDIR}/work"
export BUILDDIR="${WORKDIR}/build/"
export SRCDIR="${WORKDIR}/data-analysis-${PV}"
export HTMLPARSERPKG="${WORKDIR}/html-parser.tar.gz"
export HTMLPARSERDIR="${WORKDIR}/data-analysis-${PV}/app/html-parser"

pkg_pretend() {
	elog "BASEDIR	: 	${BASEDIR}"
	elog "BUILDDIR 	: 	${BUILDDIR}"
	elog "SRCDIR 	: 	${SRCDIR}"
	elog "Pretent ..."
}

pkg_setup() {
	elog "Setup ..."
}

src_unpack() {
	elog "Unpacking ..."
	default
	mv "${WORKDIR}/data-analysis-data-analysis-${PV}" "${WORKDIR}/jarvis-${PV}"
	rm -rf "${WORKDIR}/jarvis-${PV}/app/html-parser" "${WORKDIR}/jarvis-${PV}/app/macros"
	mv "${WORKDIR}/html-parser-html-parser-0.0.1" "${WORKDIR}/jarvis-${PV}/app/html-parser"
	mv "${WORKDIR}/macros-macros-0.0.1" "${WORKDIR}/jarvis-${PV}/app/macros"
}

src_prepare() {
	elog "Prepare ..."
	eapply_user
}

src_configure() {
	elog "Configure ..."
	cd "${WORKDIR}/jarvis-${PV}" 
	mkdir -p ${BUILDDIR}
	cmake -B "${BUILDDIR}" "${SRCDIR}" 
}

src_compile() {
	elog "Start compile ..."
	make -C "${BUILDDIR}" -j$(nproc)
}

src_test() {
	elog "Start test ..."
}

src_install() {
	elog "Start Install ..."
	install -Dm 0555 "${BUILDDIR}/app/data-analysis" "${D}${bindir}/bin/data-analysis"
}

pkg_preinst() {
	elog "Preinstall ..."
}

pkg_postinst() {
	elog "Postinstall ..."
}
