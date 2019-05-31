# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools linux-info

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc gnome gtk introspection policykit seccomp"

# FIXME: systemd is automagic dep.
RDEPEND="
	>=sys-fs/libostree-2018.9
	>=net-libs/libsoup-2.4
	>=gnome-base/dconf-0.26
	>=dev-libs/appstream-glib-0.5.10
	x11-libs/gdk-pixbuf:2
	>=dev-libs/glib-2.56:2
	>=dev-libs/libxml2-2.4
	sys-apps/dbus
	dev-libs/json-glib
	x11-apps/xauth
	>=app-arch/libarchive-2.8
	>=app-crypt/gpgme-1.1.8
	policykit? ( >=sys-auth/polkit-0.98 )
	seccomp? ( sys-libs/libseccomp )
"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.13.4
	>=sys-devel/gettext-0.18.2
	virtual/pkgconfig
	dev-util/gdbus-codegen
	sys-devel/bison
	introspection? ( >=dev-libs/gobject-introspection-1.40 )
	doc? ( >=dev-util/gtk-doc-1.20
	       dev-libs/libxslt )
"
# FIXME: is there a nicer way to do this?
PDEPEND="
	gtk? ( >=sys-apps/xdg-desktop-portal-0.10
	       sys-apps/xdg-desktop-portal-gtk )
	gnome? ( >=sys-apps/xdg-desktop-portal-0.10
		 sys-apps/xdg-desktop-portal-gtk )
"

pkg_setup() {

	local CONFIG_CHECK="~USER_NS"
	linux-info_pkg_setup

}

src_configure() {

	# FIXME: the gtk-doc check doesn't seem to be working
	# TODO: split out bubblewrap
	# TODO: split out xdg-dbus-proxy?
	econf \
		--enable-sandboxed-triggers \
		--enable-xauth \
		--localstatedir="${EPREFIX}"/var \
		--without-system-bubblewrap \
		--without-system-dbus-proxy \
		$(use_enable doc documentation) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable policykit system-helper) \
		$(use_enable seccomp)

}
