# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils meson flag-o-matic

DESCRIPTION="Vulkan-based D3D11 implementation for Linux / Wine"
HOMEPAGE="https://github.com/doitsujin/dxvk"
MY_PV=$(ver_cut 1-2)
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="https://github.com/doitsujin/dxvk/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="layers video_cards_amdgpu video_cards_intel video_cards_nvidia +winelib"

RDEPEND="|| ( >=app-emulation/wine-vanilla-3.10[vulkan] >=app-emulation/wine-staging-3.10[vulkan] >=app-emulation/wine-d3d9-3.10[vulkan] >=app-emulation/wine-any-3.10[vulkan] )
    app-emulation/winetricks
    dev-util/glslang
    layers? ( media-libs/vulkan-layers )
    video_cards_amdgpu? ( >=media-libs/mesa-19[vulkan] )
    video_cards_intel? ( >=media-libs/mesa-19[vulkan] )
    video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-415.22 )"
DEPEND="${RDEPEND}
>=dev-util/meson-0.46
!winelib? ( >=cross-x86_64-w64-mingw32/mingw64-runtime-6.0.0[libraries] )
dev-util/ninja"

REQUIRED_USE="^^ ( video_cards_amdgpu video_cards_intel video_cards_nvidia )"

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
    if use winelib; then
        if use abi_x86_64; then
            mesonargs+=(--cross-file build-wine64.txt)
        elif use abi_x86_32; then
            mesonargs+=(--cross-file build-wine32.txt)
        fi
    else    
        if use abi_x86_64; then
            mesonargs+=(--cross-file build-win64.txt)
        elif use abi_x86_32; then
            mesonargs+=(--cross-file build-win32.txt)
        fi
    fi

    # https://bugs.gentoo.org/625396
    python_export_utf8_locale
    
    BUILD_DIR="${BUILD_DIR:-${WORKDIR}/${MY_P}-build}"
    set -- meson "${mesonargs[@]}" "$@" \
        "${EMESON_SOURCE:-${S}}" "${BUILD_DIR}"
    echo "$@"
    "$@" || die
}

pkg_postinst() {
    elog "You will need to set up your WINEPREFIX for DXVK."
    elog "To do so, you need to run /usr/bin/setup_dxvk.sh"
    elog "with your WINEPREFIX set."
}