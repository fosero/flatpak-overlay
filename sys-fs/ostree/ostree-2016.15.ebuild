# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit autotools eutils systemd

SRC_URI="https://github.com/${PN}dev/${PN}/releases/download/v${PV}/${P}.tar.xz"
DESCRIPTION="OSTree is a tool for managing bootable, immutable, versioned filesystem trees."
HOMEPAGE="https://github.com/ostreedev/ostree"

LICENSE="LGPL-2"
SLOT="0"

IUSE="introspection doc man systemd"

KEYWORDS="amd64"

# NOTE: soup seems optional, but during the build it isn't
RDEPEND="
	>=dev-libs/glib-2.40:2
	>=app-arch/xz-utils-5.0.5
	sys-libs/zlib
	>=net-libs/libsoup-2.40
	>=sys-fs/fuse-2.9.2
	>=app-crypt/gpgme-1.1.8
	>=app-arch/libarchive-2.8
	systemd? ( sys-apps/systemd )
"
DEPEND="${RDEPEND}
	sys-devel/bison
	virtual/pkgconfig
	sys-fs/e2fsprogs
	introspection? ( >=dev-libs/gobject-introspection-1.34 )
	doc? ( >=dev-util/gtk-doc-1.15 )
	man? ( dev-libs/libxslt )
"

src_prepare() {

	# FIXME: should work through the build system really
	eapply ${FILESDIR}/0001-ot-gpg-utils-use-gentoo-include-path.patch

	eapply_user

	eautoreconf

}

src_configure() {

	local myconf=()

	# FIXME: it is not possible to hard disable systemd in the configure script.
	# systemd only seems needed for booting ostree
	use systemd \
		&& myconf+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )

	# FIXME: selinux should be use-flagged
	econf \
		--without-dracut \
		--without-mkinitcpio \
		--with-libarchive \
		--without-selinux \
		--without-libmount \
		--with-soup \
		$(use_enable introspection) \
		$(use_enable doc gtk-doc) \
		$(use_enable man) \
		"${myconf[@]}"

}

src_install() {

	default

	# FIXME: figure out what is failing
	# see https://github.com/fosero/flatpak-overlay/issues/1
	rm -f ${D}/etc/grub.d/15_ostree

}
