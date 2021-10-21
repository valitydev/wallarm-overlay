# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DEB_PL="1"
MY_PV="${PV}-${DEB_PL}"
RUBY_TG="2.6.0"
DEB_ARCH="all"

DESCRIPTION="Ruby library for access Wallarm API"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/debian/wallarm-node/stretch/3.2/pool/ruby-${PN}_${MY_PV}_${DEB_ARCH}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby:2.6
	 dev-ruby/json
	 dev-ruby/msgpack
	 dev-ruby/thread
	 dev-ruby/proton"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/ruby-${PN}/changelog.Debian.gz
		unpack usr/share/doc/ruby-${PN}/NEWS.Debian.gz
}

src_install() {
        dodoc usr/share/doc/ruby-${PN}/copyright
        dodoc changelog.Debian
		dodoc NEWS.Debian

		insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
		doins -r usr/lib/ruby/vendor_ruby/wallarm
}
