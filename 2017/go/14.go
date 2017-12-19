package main

import (
	"fmt"
	//"strings"
	"strconv"
)

func main() {

	// start at 1 because "0" aka start is included by default
	var input = "amgozmfv"
	//var layers = make(map[int]int)
	var total = 128

	// parse the data
	for i := 0; i < total; i++ {

		key_string := input + "-" + strconv.Itoa(i)
		fmt.Println(key_string)
		// solve day 10 for knot hash function
		// apply knot hash to each key string

	}

}