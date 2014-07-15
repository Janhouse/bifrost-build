#!/bin/bash

SRC=sqlite-3.8.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.sqlite.org/2014/sqlite-autoconf-3080500.tar.gz
