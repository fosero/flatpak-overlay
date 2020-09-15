# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit systemd

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="GTK/GNOME backend for xdg-desktop-portal"
HOMEPAGE="https://github.com/flatpak/xdg-desktop-portal-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland X"

# FIXME: The X and wayland options are autodetected.
RDEPEND="
	gnome-base/gnome-desktop:3
	gnome-base/gsettings-desktop-schemas
	media-libs/fontconfig
	>=dev-libs/glib-2.44:2[dbus]
	>=x11-libs/gtk+-3.14:3
	wayland? ( >=x11-libs/gtk+-3.21.5:3[wayland] )
	X? ( >=x11-libs/gtk+-3.14:3[X] )
	>=sys-apps/xdg-desktop-portal-1.5
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.18.3
"

src_configure() {

	econf \
		--with-systemduserunitdir="$(systemd_get_userunitdir)"

}
