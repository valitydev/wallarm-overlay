# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PV=$(ver_cut 1)
DEB_PL="1"
MY_PV="${PV##*_p}"
MY_GIT="w${MY_PV%%_*}"
MY_PV="${PV%%_*}"
MY_P="${PN}${DEB_PV}_${MY_PV}+${MY_GIT}"

DESCRIPTION="Signature-free approach library to detect attacks"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${MY_P}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-libs/glibc"
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
        dodoc usr/share/doc/${PN}${DEB_PV}/README
        dodoc usr/share/doc/${PN}${DEB_PV}/TODO
        dodoc changelog.Debian

        dolib.so usr/lib/x86_64-linux-gnu/${PN}.so.2.0.5
        dosym ${PN}.so.2.0.5 /usr/$(get_libdir)/${PN}.so.$(ver_cut 1)
}
