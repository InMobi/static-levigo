#!/bin/sh
set -e;

(
	svn checkout http://snappy.googlecode.com/svn/trunk/ snappy-read-only;
)

(
	git clone https://code.google.com/p/leveldb/ || (cd leveldb; git pull);
)

(
	MODIFIED_SOURCE=$WORKDIR/src/github.com/jmhodges/
	mkdir -p $WORKDIR/src/github.com/jmhodges
	git clone -b static-link git@github.com:anomalizer/levigo.git $MODIFIED_SOURCE/levigo || (cd $MODIFIED_SOURCE/levigo; git pull)
)
