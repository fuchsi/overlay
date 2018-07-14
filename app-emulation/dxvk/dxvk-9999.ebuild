# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils meson flag-o-matic git-r3

DESCRIPTION="Vulkan-based D3D11 implementation for Linux / Wine"
HOMEPAGE="https://github.com/doitsujin/dxvk"
SRC_URI=""
EGIT_REPO_URI="https://github.com/doitsujin/dxvk.git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="+abi_x86_32 +abi_x86_64 layers video_cards_amdgpu video_cards_intel video_cards_nvidia"

RDEPEND="|| ( >=app-emulation/wine-vanilla-3.10[vulkan] >=app-emulation/wine-staging-3.10[vulkan] >=app-emulation/wine-d3d9-3.10[vulkan] >=app-emulation/wine-any-3.10[vulkan] )
    dev-util/glslang
    layers? ( media-libs/vulkan-layers )
    video_cards_amdgpu? ( >=media-libs/mesa-18[vulkan] )
    video_cards_intel? ( >=media-libs/mesa-18[vulkan] )
    video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-396.24 )"
DEPEND="${RDEPEND}
>=dev-util/meson-0.43
cross-x86_64-w64-mingw32/mingw64-runtime[libraries]
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

pkg_postinst() {
    elog "You will need to set up your WINEPREFIX for DXVK."
    elog "To do so, you need to run /usr/bin/setup_dxvk.sh"
    elog "with your WINEPREFIX set."
}