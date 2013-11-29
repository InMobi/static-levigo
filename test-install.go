package main

import "github.com/jmhodges/levigo"
import "fmt"

func main() {
	opts := levigo.NewOptions()
	opts.SetCache(levigo.NewLRUCache(3<<30))
	opts.SetCreateIfMissing(true)

	ro := levigo.NewReadOptions()
	wo := levigo.NewWriteOptions()

	db, err := levigo.Open("/tmp/g.ldb", opts)

	err = db.Put(wo, []byte("anotherkey"), []byte("aiee"))
	fmt.Printf("%s\n", err)

	data, err := db.Get(ro, []byte("anotherkey"))
	fmt.Printf("%s %s\n", data, err)
}
