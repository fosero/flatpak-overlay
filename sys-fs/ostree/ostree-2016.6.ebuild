# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools eutils

SRC_URI="https://github.com/${PN}dev/${PN}/releases/download/v${PV}/${P}.tar.xz"
DESCRIPTION="OSTree is a tool for managing bootable, immutable, versioned filesystem trees."
HOMEPAGE="https://github.com/ostreedev/ostree"

LICENSE="LGPL-2"
SLOT="0"

IUSE="introspection doc man"

KEYWORDS="amd64"

# NOTE: soup seems optional, but during the build it isn't
RDEPEND="
	>=dev-libs/glib-2.40:2
	=dev-libs/libgsystem-2015.1
	>=app-arch/xz-utils-5.0.5
	sys-libs/zlib
	>=net-libs/libsoup-2.40
	>=sys-fs/fuse-2.9.2
	>=app-crypt/gpgme-1.1.8
	>=app-arch/libarchive-2.8
"
DEPEND="${RDEPEND}
	sys-devel/bison
	dev-util/pkgconfig
	sys-fs/e2fsprogs
	introspection? ( >=dev-libs/gobject-introspection-1.34 )
	doc? ( >=dev-util/gtk-doc-1.15 )
	man? ( dev-libs/libxslt )
"

src_prepare() {

	# FIXME: should work through the build system really
	epatch ${FILESDIR}/0001-ot-gpg-utils-use-gentoo-include-path.patch

	# FIXME: eautogen fails to do the right thing for some reason
	./autogen.sh

}

src_configure() {

	econf \
		--without-dracut \
		--without-mkinitcpio \
		--with-libarchive \
		--without-selinux \
		--without-libmount \
		--with-soup \
		$(use_enable introspection) \
		$(use_enable doc gtk-doc) \
		$(use_enable man)

}
