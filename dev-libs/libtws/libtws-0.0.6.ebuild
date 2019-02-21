# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PV=$(ver_cut 1)

DESCRIPTION="Tiny Websocket protocol parser library"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${PN}${DEB_PV}_${PV}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-libs/glibc
         sys-libs/zlib"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/${PN}${DEB_PV}/changelog.gz
}

src_install() {
        dodoc usr/share/doc/${PN}${DEB_PV}/copyright
        dodoc usr/share/doc/${PN}${DEB_PV}/README.md
        dodoc changelog

        dolib.so usr/lib/${PN}.so.0.0.4
        dosym ${PN}.so.0.0.4 /usr/$(get_libdir)/${PN}.so.$(ver_cut 1)
}
