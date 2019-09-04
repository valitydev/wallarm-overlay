# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="1"
MY_PV="${PV##*_p}"
MY_GIT="rbkmoney${MY_PV%%_*}"
MY_PV="${PV%%_*}"
MY_P="${PN}_${MY_PV}-${DEB_PL}+${MY_GIT}"

DESCRIPTION="Wallarm security engine nginx module"
HOMEPAGE="http://wallarm.com"
SRC_URI="http://repo.wallarm.com/debian/wallarm-node-rbkmoney/stretch/pool/${MY_P}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+monitoring"

DEPEND=""
RDEPEND="dev-libs/libconfig
         =www-servers/nginx-1.16.1*
		 dev-db/lmdb
		 dev-libs/libproton
		 dev-libs/libtws
		 dev-libs/libwacl
		 dev-libs/libwlog
		 dev-libs/libwyajl
		 dev-libs/libyaml
		 app-admin/wallarm-common
		 monitoring? ( app-admin/wallarm-monitoring )"
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
        dodoc usr/share/doc/${PN}/copyright
        dodoc changelog.Debian
        dodoc -r usr/share/doc/${PN}/examples

        insinto "/usr/$(get_libdir)/nginx/modules"
        doins usr/lib/nginx/modules/ngx_http_wallarm_module.so
        fperms 755 /usr/$(get_libdir)/nginx/modules/ngx_http_wallarm_module.so

        insinto "/etc"
        doins -r etc/wallarm
        if use monitoring ; then
          doins -r etc/collectd
        fi
}
