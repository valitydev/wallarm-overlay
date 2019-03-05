# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_ARCH="all"
RUBY_TG="2.5.0"

DESCRIPTION="Wallarm - common files"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/ubuntu/wallarm-node/bionic/pool/${PN}_${PV}_${DEB_ARCH}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="logrotate"

DEPEND=""
RDEPEND="logrotate? ( app-admin/logrotate )
         dev-lang/ruby:2.5
         dev-ruby/hashie
         dev-ruby/highline
         dev-ruby/rest-client
         dev-ruby/wallarm-api
         dev-ruby/proton"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/${PN}/changelog.gz
        unpack usr/share/doc/${PN}/NEWS.Debian.gz
}

src_install() {
        dodoc usr/share/doc/${PN}/copyright
        dodoc changelog
        dodoc NEWS.Debian

        if use logrotate ; then
          insinto "/etc/logrotate.d"
          newins etc/logrotate.d/${PN} ${PN}
        fi

        insinto "/etc"
        doins -r etc/wallarm 

        insinto "/usr/share"
        doins -r usr/share/wallarm-common
        fperms 755 /usr/share/${PN}/*
        fperms 644 /usr/share/${PN}/ca.pem

        insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
        doins -r usr/lib/ruby/vendor_ruby/wallarm
}
