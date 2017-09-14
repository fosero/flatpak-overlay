# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Tool for building flatpaks from sources"
HOMEPAGE="http://flatpak.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	>=sys-apps/flatpak-${PV}
	>=sys-fs/libostree-2017.10
	>=net-libs/libsoup-2.4
	>=dev-libs/elfutils-0.8.12
	>=dev-libs/glib-2.44:2
	dev-libs/json-glib
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.2
	virtual/pkgconfig
	doc? ( app-text/xmlto
	       dev-libs/libxslt )
"

src_configure() {

	econf \
		$(use_enable doc documentation) \
		$(use_enable doc docbook-docs)

}
