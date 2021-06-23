# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

MY_PV=$(ver_rs 1 '')
DEB_PV=$(ver_cut 1 "${MY_PV}")
DEB_PL="1"

DESCRIPTION="Wallarm Web Application Firewall - core libraries"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/debian/wallarm-node/stretch/2.18/pool/${PN}${DEB_PV}_${PV}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="app-arch/brotli
         dev-libs/libconfig
		 dev-libs/libcpire
		 dev-libs/libdetection
		 dev-libs/libhubbub
		 dev-libs/openssl:0/1.1
		 dev-libs/libwlog
		 dev-libs/libwyajl
		 dev-libs/libxml2
		 sys-libs/zlib"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/${PN}${DEB_PV}/changelog.Debian.gz
}

src_install() {
        dodoc usr/share/doc/${PN}${DEB_PV}/copyright
        dodoc changelog.Debian

        dolib.so usr/lib/x86_64-linux-gnu/${PN}.so.${PV}
        dosym ${PN}.so.${PV} /usr/$(get_libdir)/${PN}.so.$(ver_cut 1-2)
}
