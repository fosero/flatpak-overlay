# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="no"

inherit autotools gnome2

SRC_URI="https://git.gnome.org/browse/libgsystem/snapshot/${P}.tar.xz"

DESCRIPTION="GIO-based library for use by operating system components"
HOMEPAGE="https://wiki.gnome.org/Projects/LibGSystem"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE="+introspection +systemd"

# FIXME: this probably doesn't work with newer versions of systemd
#	 there is a patch in git to fix this
RDEPEND="
	>=dev-libs/glib-2.34:2
	sys-apps/attr
	introspection? ( >=dev-libs/gobject-introspection-1.34 )
	systemd? ( >=sys-apps/systemd-200 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	>=dev-libs/libxslt-1
	virtual/pkgconfig
"

src_prepare() {
        eautoreconf
        gnome2_src_prepare
}
