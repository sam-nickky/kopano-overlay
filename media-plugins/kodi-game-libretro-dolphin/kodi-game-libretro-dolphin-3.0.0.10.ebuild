# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Dolphin GameClient for Kodi"
HOMEPAGE="https://github.com/kodi-game/game.libretro.dolphin"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/kodi-game/game.libretro.dolphin.git"
	inherit git-r3
	DEPEND="${DEPEND}
		~media-tv/kodi-9999"
else
	KEYWORDS="~amd64 ~x86"
	CODENAME="Matrix"
	SRC_URI="https://github.com/kodi-game/game.libretro.dolphin/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/game.libretro.dolphin-${PV}-${CODENAME}"
	DEPEND="${DEPEND}
		=media-tv/kodi-19*"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	${DEPEND}
	games-emulation/libretro-dolphin
	"
RDEPEND="
	media-plugins/kodi-game-libretro
	${DEPEND}
	"
src_prepare() {
	echo 'find_library(DOLPHIN_LIB NAMES dolphin_libretro${CMAKE_SHARED_LIBRARY_SUFFIX} PATH_SUFFIXES libretro)' > "${S}/Findlibretro-dolphin.cmake" || die
	cmake_src_prepare
}
