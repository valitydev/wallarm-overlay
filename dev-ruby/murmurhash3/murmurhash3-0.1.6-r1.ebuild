# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

RUBY_TG="2.6.0"
DEB_PL="6"

DESCRIPTION="Wallarm Web Application Firewall - ruby bindings"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/debian/wallarm-node/buster/3.2/pool/ruby-${PN}_${PV}-${DEB_PL}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby:2.6"
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
                dodir /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}/x86_64-linux/${PN}
		doins -r usr/lib/x86_64-linux-gnu/ruby/vendor_ruby/2.5.0/${PN}
		fperms 755 /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}/x86_64-linux/${PN}/native_murmur.so
		insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
		doins usr/lib/ruby/vendor_ruby/${PN}.rb
		doins -r usr/lib/ruby/vendor_ruby/${PN}
}

