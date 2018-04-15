# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils meson flag-o-matic

DESCRIPTION="Vulkan-based D3D11 implementation for Linux / Wine"
HOMEPAGE="https://github.com/doitsujin/dxvk"
SRC_URI="https://github.com/doitsujin/dxvk/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+abi_x86_32 +abi_x86_64"

RDEPEND=">=app-emulation/wine-vanilla-3.5[vulkan]
    dev-util/glslang
    >=media-libs/mesa-18[vulkan]"
DEPEND="${RDEPEND}
dev-util/meson
cross-x86_64-w64-mingw32/mingw64-runtime[libraries]
dev-util/ninja"

src_configure() {
    local mesonargs=(
        -Dbuildtype=release        
        -Denable_tests=false
        --libdir "$(get_libdir)"
        --localstatedir "${EPREFIX}/var/lib"
        --prefix "${EPREFIX}/usr"
        --sysconfdir "${EPREFIX}/etc"
        --wrap-mode nodownload
    )
    if use abi_x86_64; then
        mesonargs+=(--cross-file build-win64.txt)
        echo "win64"
    elif use abi_x86_32; then
        mesonargs+=(--cross-file build-win32.txt)
    fi

    # https://bugs.gentoo.org/625396
    python_export_utf8_locale
    
    BUILD_DIR="${BUILD_DIR:-${WORKDIR}/${P}-build}"
    set -- meson "${mesonargs[@]}" "$@" \
        "${EMESON_SOURCE:-${S}}" "${BUILD_DIR}"
    echo "$@"
    "$@" || die
}

#src_install() {
#    local DXVK_ARCH="64"
#    if use abi_x86_32; then
#        DXVK_ARCH="32"
#    fi
#    doexe install.${DXVK_ARCH}/bin/setup_dxvk.sh
#}