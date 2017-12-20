package main

import (
	"fmt"
	//"strings"
	"strconv"
)

func main() {

	var a = 699
	var b = 124
	// example
	// var a = 65
	// var b = 8921
	var a_factor = 16807
	var b_factor = 48271
	var divisor = 2147483647
	var matching_pairs = 0
	var max_pairs = 40000000

	for i := 0; i < max_pairs; i++ {

		a = a * a_factor % divisor
		b = b * b_factor % divisor
		
		a64 := pad(strconv.FormatInt(int64(a), 2))
		b64 := pad(strconv.FormatInt(int64(b), 2))

		if a64[16:32] == b64[16:32] {
			matching_pairs++
		}

	}

	fmt.Println(matching_pairs)

}

func pad(binary string) string {
	current := len(binary)
	for i := 0; i<32-current;i++ {
		binary = "0"+binary
	}
	return binary
}