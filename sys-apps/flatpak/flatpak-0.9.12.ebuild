# Copyright 1999-207 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools linux-info

SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Application distribution framework"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc gnome gtk introspection policykit seccomp"

RDEPEND="
	>=sys-fs/libostree-2017.10
	>=net-libs/libsoup-2.4
	>=dev-libs/glib-2.44:2
	>=dev-libs/libxml2-2.4
	sys-fs/fuse
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

pkg_pretend() {

	if [ -d "/var/lib/lib/flatpak" ]; then
		ewarn "The directory /var/lib/lib/flatpak exists."
		elog "You seem to have an existing /var/lib/lib/flatpak directory."
		elog "This probably means you have system-wide installed runtimes"
		elog "or applications. However, this directory is incorrect and"
		elog "flatpak 0.9 and up will install systemw-wide runtimes and"
		elog "applications in /var/lib/flatpak instead."
		elog "Suggested course of action is to uninstall any runtime and/or"
		elog "application that is installed system-wide and remove the"
		elog "/var/lib/lib/flatpak directory, then re-install from scratch"
		elog "with flatpak 0.9 ."
		elog "Apologies for the inconvenience."

		die "/var/lib/lib/flatpak exists."
	fi

}

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
		--localstatedir="${EPREFIX}"/var \
		--without-system-bubblewrap \
		$(use_enable doc documentation) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable policykit system-helper) \
		$(use_enable seccomp)

}
