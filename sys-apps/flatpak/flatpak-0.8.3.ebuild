# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit autotools linux-info

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc gnome gtk introspection policykit seccomp"

RDEPEND="
	>=sys-fs/libostree-2016.14
	>=net-libs/libsoup-2.4
	dev-libs/glib:2
	sys-fs/fuse
	sys-apps/dbus
	dev-libs/json-glib
	>=dev-libs/elfutils-0.8.12
	x11-apps/xauth
	>=app-arch/libarchive-2.8
	policykit? ( >=sys-auth/polkit-0.98 )
	seccomp? ( sys-libs/libseccomp )
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.2
	virtual/pkgconfig
	dev-util/gdbus-codegen
	introspection? ( >=dev-libs/gobject-introspection-1.40 )
	doc? ( >=dev-util/gtk-doc-1.20
	       dev-libs/libxslt )
"
# FIXME: is there a nicer way to do this?
PDEPEND="
	gtk? ( sys-apps/xdg-desktop-portal
	       sys-apps/xdg-desktop-portal-gtk )
	gnome? ( sys-apps/xdg-desktop-portal
		 sys-apps/xdg-desktop-portal-gtk )
"

pkg_setup() {

	local CONFIG_CHECK="~USER_NS"
	linux-info_pkg_setup

}

src_configure() {

	# FIXME: the gtk-doc check doesn't seem to be working
	# FIXME: split out bubblewrap
	econf \
		--enable-sandboxed-triggers \
		--enable-xauth \
		--without-system-bubblewrap \
		$(use_enable doc documentation) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable policykit system-helper) \
		$(use_enable seccomp)

}
