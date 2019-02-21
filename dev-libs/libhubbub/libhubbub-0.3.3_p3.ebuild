# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="1"
MY_PV="${PV##*_p}"
MY_GIT="wallarm${MY_PV%%_*}"
MY_PV="${PV%%_*}"
MY_P="${PN}_${MY_PV}+${MY_GIT}"

DESCRIPTION="Hubbub -- an HTML parser"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${MY_P}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libparserutils"
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
        dodoc changelog.Debian
		dodoc usr/share/doc/${PN}/README
		dodoc usr/share/doc/${PN}/copyright

        dolib.so usr/lib/${PN}.so.${MY_PV}
        dosym ${PN}.so.${MY_PV} /usr/$(get_libdir)/${PN}.so.$(ver_cut 1)
}
