WORKDIR :=$(shell pwd)

.PHONY : fetch libsnappy libleveldb levigo

all: levigo

fetch:
	WORKDIR=${WORKDIR} ./fetch_sources.sh

snappy-read-only/.libs/libsnappy.a:
	set -e; \
	cd snappy-read-only; \
	./autogen.sh; \
	./configure --enable-shared=no --enable-static=yes; \
	make clean; \
	make CXXFLAGS='-g -O2';

libsnappy: snappy-read-only/.libs/libsnappy.a


leveldb/libleveldb.a: libsnappy
	set -e; \
	cd leveldb; \
	make clean; \
	make libleveldb.a LDFLAGS='-L../snappy-read-only/.libs/ -Bstatic -lsnappy' OPT='-O2 -DNDEBUG -DSNAPPY -I../snappy-read-only' SNAPPY_CFLAGS=''

libleveldb: leveldb/libleveldb.a

levigo: libleveldb
	GOPATH=${WORKDIR} CGO_CFLAGS="-I${WORKDIR}/leveldb/include -Isnappy-read-only" CGO_LDFLAGS="-L${WORKDIR}/leveldb -L${WORKDIR}/snappy-read-only/.libs -lsnappy" go install github.com/jmhodges/levigo


clean:
	rm -rf snappy-read-only/.libs/libsnappy.a leveldb/libleveldb.a
	rm -rf pkg/*/github.com/jmhodges/levigo.a
