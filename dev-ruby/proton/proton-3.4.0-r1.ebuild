# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DEB_PL="1"
MY_PV="${PV}-${DEB_PL}"
RUBY_TG="2.7.0"
DEB_ARCH="amd64"

DESCRIPTION="Wallarm Web Application Firewall - ruby bindings"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/ubuntu/wallarm-node/focal/3.4/pool/ruby-${PN}_${MY_PV}_${DEB_ARCH}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libconfig
         >=dev-libs/libproton-3.4.0
	 dev-lang/ruby:2.7
	 dev-libs/libwlog
	 dev-ruby/msgpack
	 dev-ruby/murmurhash3
	 dev-ruby/parser-generator"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/ruby-${PN}/changelog.Debian.gz
}

src_install() {
        dodoc usr/share/doc/ruby-${PN}/copyright
        dodoc changelog.Debian

        insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}/x86_64-linux/
		doins -r usr/lib/x86_64-linux-gnu/ruby/vendor_ruby/${RUBY_TG}/${PN}
		fperms 755 /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}/x86_64-linux/${PN}/${PN}.so
		insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
		doins usr/lib/ruby/vendor_ruby/${RUBY_TG}/${PN}.rb
		doins -r usr/lib/ruby/vendor_ruby/${RUBY_TG}/${PN}
		dosym /usr/$(get_libdir)/libruby27.so.2.7 /usr/$(get_libdir)/libruby-2.7.so.2.7

}
