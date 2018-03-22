# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils multilib

DESCRIPTION="Small utilities that are useful in advanced password crackingy"
HOMEPAGE="https://github.com/hashcat/hashcat-utils"
SRC_URI="https://github.com/hashcat/hashcat-utils/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="sys-devel/make"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_install() {
	for x in *.bin; do
		newbin "$x" "$(basename $x .bin)"
	done
}
