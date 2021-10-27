# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="1"
MY_PV="${PV}-${DEB_PL}"
DEB_ARCH="all"
RUBY_TG="2.7.0"

DESCRIPTION="Wallarm - common files"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/ubuntu/wallarm-node/focal/3.4/pool/${PN}_${MY_PV}_${DEB_ARCH}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="logrotate"

DEPEND=""
RDEPEND="logrotate? ( app-admin/logrotate )
         dev-lang/ruby:2.7
         dev-ruby/hashie
         dev-ruby/highline
         dev-ruby/sqlite3
         dev-ruby/rest-client
         >=dev-ruby/wallarm-api-3.4.0
         >=dev-ruby/proton-3.4.0"
BDEPEND=""

src_unpack() {
        mkdir "${WORKDIR}/${P}" && cd "${WORKDIR}/${P}"
        unpack_deb ${A}
}

src_prepare() {
        eapply_user

        unpack usr/share/doc/${PN}/changelog.Debian.gz
        unpack usr/share/doc/${PN}/NEWS.Debian.gz
}

src_install() {
        dodoc usr/share/doc/${PN}/copyright
        dodoc changelog.Debian
        dodoc NEWS.Debian

        if use logrotate ; then
          insinto "/etc/logrotate.d"
          newins etc/logrotate.d/${PN} ${PN}
        fi

        insinto "/etc"
        doins -r etc/wallarm 

        insinto "/usr/share/${PN}"
        doins usr/share/${PN}/ca.pem
        exeinto "/usr/share/${PN}"
        for f in $(ls -1 usr/share/${PN}/|grep -v ca.pem); do
          doexe usr/share/${PN}/${f}
        done

        insinto /usr/$(get_libdir)/ruby/vendor_ruby/${RUBY_TG}
        doins -r usr/lib/ruby/vendor_ruby/wallarm
}
