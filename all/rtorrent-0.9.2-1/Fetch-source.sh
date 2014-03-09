#!/bin/bash

SRC=rtorrent-0.9.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://libtorrent.rakshasa.no/downloads/rtorrent-0.9.2.tar.gz
