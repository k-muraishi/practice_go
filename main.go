package main

import (
	"net/http"
	"practice_go/shop"
)

func main() {
	myshop := shop.NewGyudon()
	http.HandleFunc("/", myshop.Eat)
	err := http.ListenAndServe(":9000", nil)
	if err != nil {
		panic(err)
	}
}
