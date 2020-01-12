# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="Flatpak portal library"
HOMEPAGE="https://github.com/flatpak/libportal"

LICENSE="LGPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64"

RDEPEND="dev-libs/glib:2"

DEPEND="${RDEPEND}
	dev-util/gtk-doc"

src_configure() {

	local emesonargs=(
		-Dbuild-portal-test=false
	)

	meson_src_configure

}
