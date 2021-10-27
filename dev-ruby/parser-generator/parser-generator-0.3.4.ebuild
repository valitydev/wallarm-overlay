# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

RUBY_TG="2.7.0"
MY_PV="${PV}-wallarm3.4+1"
DEB_PL="1"
DEB_ARCH="all"

DESCRIPTION="Parser Generator"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/focal/3.4/pool/ruby-${PN}_${MY_PV}_${DEB_ARCH}.deb"

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
                doins usr/lib/ruby/vendor_ruby/$(ver_rs 1- _ ${PN}).rb
                doins -r usr/lib/ruby/vendor_ruby/$(ver_rs 1- _ ${PN})
}
