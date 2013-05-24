#!/bin/bash

SRC=netperf-2.6.0.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.netperf.org/netperf/$SRC || wget -O $DST ftp://ftp.netperf.org/netperf/archive/$SRC
