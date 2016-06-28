# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="no"

inherit autotools gnome2 linux-info

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="archive doc introspection policykit seccomp"

# FIXME: pin the only working libgsystem version
RDEPEND="
	=dev-libs/libgsystem-2015.1
	>=sys-fs/ostree-2016.5
	>=net-libs/libsoup-2.4
	dev-libs/glib:2
	sys-fs/fuse
	sys-apps/dbus
	dev-libs/json-glib
	>=dev-libs/elfutils-0.8.12
	x11-apps/xauth
	archive? ( >=app-arch/libarchive-2.8 )
	policykit? ( >=sys-auth/polkit-0.98 )
	seccomp? ( sys-libs/libseccomp )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.24
	introspection? ( >=dev-libs/gobject-introspection-1.40 )
	doc? ( >=dev-util/gtk-doc-1.20
	       dev-libs/libxslt )
"

pkg_setup() {

	local CONFIG_CHECK="~USER_NS"
	linux-info_pkg_setup

}

src_prepare() {

        eautoreconf
        gnome2_src_prepare

}


src_configure() {

	# FIXME: the gtk-doc check doesn't seem to be working
	gnome2_src_configure \
		--enable-sandboxed-triggers \
		--enable-xauth \
		$(use_with archive libarchive) \
		$(use_enable doc documentation) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable policykit system-helper) \
		$(use_enable seccomp)

}
