# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="1"
MY_PV="${PV##*_p}"
MY_GIT="git${MY_PV%%_*}"
MY_PV="${PV%%_*}"
MY_P="${PN}_${MY_PV}+${MY_GIT}"

DESCRIPTION="Perl Incompatible Regular Expressions library"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${MY_P}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
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

        dolib.so usr/lib/${PN}.so.0.0.0
        dosym ${PN}.so.0.0.0 /usr/$(get_libdir)/${PN}.so.0
}
