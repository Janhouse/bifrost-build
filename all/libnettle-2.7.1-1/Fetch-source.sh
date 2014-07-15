#!/bin/bash

SRC=nettle-2.7.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/gnu/nettle/$SRC
