# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils

SRC_URI="mirror://kde/stable/plasma/${PV}/${P}.tar.xz"
DESCRIPTION="A backend implementation for xdg-desktop-portal using Qt/KF5"
HOMEPAGE="https://github.com/KDE/xdg-desktop-portal-kde"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=kde-frameworks/extra-cmake-modules-5.42.0
	>=kde-frameworks/ki18n-5.42.0
	>=kde-frameworks/knotifications-5.42.0
	>=kde-frameworks/kcoreaddons-5.42.0
	>=kde-frameworks/kwidgetsaddons-5.42.0
	>=kde-frameworks/kwayland-5.42.0
	>=dev-qt/qtcore-5.9.0
	>=dev-qt/qtgui-5.9.0
	>=dev-qt/qtwidgets-5.9.0
	>=dev-qt/qtconcurrent-5.9.0
	>=dev-qt/qtdbus-5.9.0
	>=dev-qt/qtprintsupport-5.9.0
"

RDEPEND="${DEPEND}
	sys-apps/xdg-desktop-portal
	sys-apps/flatpak
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=RELEASE
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_INSTALL_LIBEXECDIR=/usr/$(get_libdir)/libexec
		-DBUILD_TESTING=OFF
	)

	cmake-utils_src_configure
}
