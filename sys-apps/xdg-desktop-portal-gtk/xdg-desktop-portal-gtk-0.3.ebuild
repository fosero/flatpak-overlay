# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="GTK/GNOME backend for xdg-desktop-portal"
HOMEPAGE="https://github.com/flatpak/xdg-desktop-portal-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="wayland X"

# The X and wayland options are autodetected
RDEPEND="
	dev-libs/glib:2[dbus]
	x11-libs/gtk+:3
	wayland? ( >=x11-libs/gtk+-3.21.5:3[wayland] )
	X? ( x11-libs/gtk+:3[X] )
	sys-apps/xdg-desktop-portal
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.24
	>=sys-devel/gettext-0.18.3
"
