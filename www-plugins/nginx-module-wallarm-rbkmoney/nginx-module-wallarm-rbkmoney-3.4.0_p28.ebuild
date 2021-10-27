# Copyright 2019 RBK.MONEY
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker 

DEB_PL="3"
MY_PV="${PV%%_*}"
TMP_PV="${PV##*_p}"
MY_GIT="rbkmoney${TMP_PV%%_*}"
MY_P="${PN}_${MY_PV}-${DEB_PL}+${MY_GIT}"

DESCRIPTION="Wallarm security engine nginx module"
HOMEPAGE="http://wallarm.com"
SRC_URI="https://repo.wallarm.com/ubuntu/wallarm-node-rbkmoney/focal/pool/${MY_P}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+monitoring"

DEPEND=""
RDEPEND="dev-libs/libconfig
         =www-servers/nginx-1.20.1*
         dev-db/lmdb
         >=dev-libs/libproton-3.4.0
	 dev-libs/libtws
	 dev-libs/libwacl
	 dev-libs/libwlog
	 dev-libs/libwyajl
	 dev-libs/libyaml
	 >=app-admin/wallarm-common-3.4.0
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
          insinto "/etc/collectd/conf.d"
          doins -r etc/collectd/wallarm-collectd.conf.d/nginx-wallarm.conf
        fi
}

