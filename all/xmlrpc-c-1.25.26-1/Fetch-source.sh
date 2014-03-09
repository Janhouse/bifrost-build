#!/bin/bash

SRC=xmlrpc-c-1.25.26.tgz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST "http://downloads.sourceforge.net/project/xmlrpc-c/Xmlrpc-c%20Super%20Stable/1.25.26/xmlrpc-c-1.25.26.tgz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fxmlrpc-c%2Ffiles%2FXmlrpc-c%2520Super%2520Stable%2F1.25.26%2F&ts=1394380530&use_mirror=garr"
