#!/bin/bash

SRCVER=rtorrent-0.9.2
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed "$1" $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Fetch sources
#./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
pkg_available uClibc-0.9.33.2-1 mm-common-0.9.6-1 libtorrent-0.13.2-1 autoconf-2.65-1 m4-1.4.14-1 automake-1.13.1-1 libtool-2.4-1 cppunit-1.13.1-1 pkg-config-0.23-1 openssl-1.0.1f-1 libsigc++-2.3.1-1 ncurses-lib-5.9-1 curl-7.20.1-2 curl-devel-7.20.1-1 xmlrpc-c-1.25.26-1 perl-5.10.1-1 zlib-1.2.7-1
pkg_install uClibc-0.9.33.2-1 || exit 2
pkg_install mm-common-0.9.6-1 || exit 2
pkg_install libtorrent-0.13.2-1 || exit 2
pkg_install autoconf-2.65-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install automake-1.13.1-1 || exit 2
pkg_install libtool-2.4-1 || exit 2
pkg_install cppunit-1.13.1-1 || exit 2
pkg_install pkg-config-0.23-1 || exit 2
pkg_install openssl-1.0.1f-1 || exit 2
pkg_install libsigc++-2.3.1-1 || exit 2
pkg_install ncurses-lib-5.9-1 || exit 2
pkg_install curl-7.20.1-2 || exit 2
pkg_install curl-devel-7.20.1-1 || exit 2
pkg_install xmlrpc-c-1.25.26-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install zlib-1.2.7-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xzf $SRC

#########
# Patch
cd $BUILDDIR
#cd /home/janhouse/src/libtorrent-0.13.2/

libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac

#export PTHREAD_LIBS=-lpthread
PTHREAD_LIBS=-lpthread ./autogen.sh

#########
# Configure
B-configure-1 --with-xmlrpc-c --prefix=/usr --enable-static || exit 1
#PTHREAD_LIBS=-lpthread ./configure --prefix=/usr --enable-static || exit 1

#########
# Post configure patch
sed -i 's/--run aclocal-1.11/--run aclocal-1.13/g' Makefile
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share/man usr/share/info usr/share/doc
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
#[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
