#!/bin/sh
set -e
./compile_leveldb.sh
WORKDIR=`pwd`
CGO_CFLAGS="-I$WORKDIR/leveldb/include -Isnappy-read-only" CGO_LDFLAGS="-L$WORKDIR/leveldb -L$WORKDIR/snappy-read-only -lsnappy" go get github.com/jmhodges/levigo
