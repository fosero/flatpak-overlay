# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit systemd

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="A portal frontend service for Flatpak and possibly other desktop containment frameworks"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

#FIXME: Needs a newer geoclue.
#
#IUSE="doc geolocation"
#	geolocation? ( >=app-misc/geoclue-2.5.2:2.0 )
#		$(use_enable geolocation geoclue) \

RDEPEND="
	dev-libs/glib:2[dbus]
	media-libs/fontconfig
	sys-fs/fuse
	!<=sys-apps/flatpak-0.10.3
	sys-apps/flatpak
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.3
	virtual/pkgconfig
	doc? ( app-text/xmlto
	       app-text/docbook-xml-dtd:4.3 )
"
# FIXME: Add pipewire support.
src_configure() {

	econf \
		$(use_enable doc docbook-docs) \
		--disable-geoclue \
		--with-systemduserunitdir="$(systemd_get_userunitdir)" \
		--disable-pipewire

}
