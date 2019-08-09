# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="3"

DESCRIPTION="Wallarm access control list library"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${PN}_${PV}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-db/lmdb"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/${PN}/changelog.gz
}

src_install() {
        dodoc usr/share/doc/${PN}/copyright
        dodoc changelog

        dolib.so usr/lib/x86_64-linux-gnu/${PN}.so.1.0.0
        dosym ${PN}.so.1.0.0 /usr/$(get_libdir)/${PN}.so.$(ver_cut 1)
}
