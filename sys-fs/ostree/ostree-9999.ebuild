# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
AT_NOEAUTOMAKE="yes"

inherit autotools bash-completion-r1 eutils gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="OSTree is a tool for managing bootable, immutable, versioned filesystem trees."
HOMEPAGE="https://wiki.gnome.org/Projects/OSTree"

LICENSE="LGPL-2"
SLOT="0"

IUSE="introspection doc man"

if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	DOCS=""
	IUSE="${IUSE} doc"
else
	KEYWORDS="~amd64"
fi

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

	# FIXME: eautogen fails to do the right thing for some reason
	./autogen.sh

	# FIXME: should work through the build system really
	epatch ${FILESDIR}/0001-ot-gpg-utils-use-gentoo-include-path.patch

	gnome2_src_prepare

}

src_configure() {

	gnome2_src_configure \
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
