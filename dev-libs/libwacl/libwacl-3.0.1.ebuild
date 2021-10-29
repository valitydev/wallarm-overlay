# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DEB_PL="wallarm3.4+1"

DESCRIPTION="Wallarm access control list library"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/ubuntu/wallarm-node/focal/3.4/pool/${PN}_${PV}-${DEB_PL}_amd64.deb"

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

        unpack usr/share/doc/${PN}/changelog.Debian.gz
}

src_install() {
        dodoc usr/share/doc/${PN}/copyright
        dodoc changelog.Debian

        dolib.so usr/lib/x86_64-linux-gnu/${PN}.so.3.0.0
        dosym ${PN}.so.3.0.0 /usr/$(get_libdir)/${PN}.so.$(ver_cut 1)
}