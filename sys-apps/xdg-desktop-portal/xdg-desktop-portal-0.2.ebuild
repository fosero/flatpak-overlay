# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="A portal frontend service for Flatpak and possibly other desktop containment frameworks"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND="
	dev-libs/glib:2[dbus]
	sys-apps/flatpak
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.3
	>=dev-util/pkgconfig-0.24
	doc? ( app-text/xmlto
	       app-text/docbook-xml-dtd:4.3 )
"

src_configure() {

	econf \
		$(use_enable doc docbook-docs)

}
