# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

RUBY_TG="2.7.0"
DEB_ARCH="all"
MY_PV="${PV##*_p}"
MY_GIT="${MY_PV%%_*}+7e91ca4+wallarm3.4.0+1"
MY_PV="${PV%%_*}"
MY_P="${PN}_${MY_PV}+${MY_GIT}"

DESCRIPTION="Parser Generator"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/focal/3.4/pool/ruby-${MY_P}_${DEB_ARCH}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby:2.7"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/ruby-${PN}/changelog.gz
}

src_install() {
        dodoc usr/share/doc/ruby-${PN}/copyright
        dodoc changelog

		insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
		doins -r usr/lib/ruby/vendor_ruby/${PN}
}
