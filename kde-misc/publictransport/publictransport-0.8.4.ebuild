# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#inherit kde4-base

DESCRIPTION="KDE plasmoid. This applet shows a departure board for a given stop."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=106175"
MY_P=${P/_beta/-beta}
#MY_P2=${P/_beta/}
MY_P2="publictransport-0.8.3_timetablemate-0.2.1"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/106175-${MY_P}_ttmate-0.2.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
"

### Variables
MY_WORKDIR="${WORKDIR}"/"${MY_P2}"
APPLET="plasma-applet-publictransport-0.8.3"
DE_OPEN="plasma-dataengine-openstreetmap-0.1.1"
DE_PUBLIC="plasma-dataengine-publictransport-0.8.3"
ICONS="publictransport-icons-0.8.3"
TIME="timetablemate-0.1"

src_unpack() {
	unpack ${A}
}

src_compile() {
	echo "Applet"
	cd "${MY_WORKDIR}/${APPLET}"
	mkdir build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ..
	make

	echo "Dataeengine-OpenStreetMap"
	cd "${MY_WORKDIR}"/"${DE_OPEN}"
	mkdir build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ..
	make
	
	echo "Dataeengine-Publictransport"
	cd "${MY_WORKDIR}"/"${DE_PUBLIC}"
	mkdir build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ..
	make
		
	echo "Icons"
	cd "${MY_WORKDIR}/${ICONS}"
	mkdir build
	#cp "${FILESDIR}/CMakeLists.txt" ./	
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ..
	make

	#echo "TimetableMate"
	#cd "${MY_WORKDIR}/${TIME}"
	#mkdir build
	#cd build
	#cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ..
	#make



}

src_install() {

	echo "Applet"
	cd "${MY_WORKDIR}/${APPLET}/build"
	pwd
	make DESTDIR="${D}" install || die "make install failed"

	echo "Dataeengine-OpenStreetMap"
	cd "${MY_WORKDIR}"/"${DE_OPEN}/build"
	make DESTDIR="${D}" install || die "make install failed"	
	
	echo "Dataeengine-Publictransport"
	cd "${MY_WORKDIR}"/"${DE_PUBLIC}/build"
	make DESTDIR="${D}" install || die "make install failed"

	echo "Icons"
	cd "${MY_WORKDIR}/${ICONS}/build"
	make DESTDIR="${D}" install || die "make install failed"

	#echo "TimetableMate"
    #cd "${MY_WORKDIR}/${TIME}/build"
    #make DESTDIR="${D}" install || die "make install failed"

}
