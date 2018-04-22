# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="OMEMO for libpurple - interoperable with other OMEMO clients"
HOMEPAGE="https://github.com/gkdr/lurch"
SRC_URI="https://github.com/gkdr/lurch/releases/download/v${PV}/lurch-${PV}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="net-im/pidgin[gtk]
    dev-libs/libxml2
    dev-libs/mxml
    dev-db/sqlite"
	
DEPEND="${RDEPEND}
    dev-util/cmake
	dev-util/intltool
	virtual/pkgconfig"

DOCS=( README.md )
