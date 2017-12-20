package main

import (
	"fmt"
	//"strings"
	"strconv"
)

func main() {

	var a = 699
	var b = 124
	var a_factor = 16807
	var b_factor = 48271
	var divisor = 2147483647
	var matching_pairs = 0
	var max_pairs = 5000000
	var a_found = []int{}
	var b_found = []int{}

	for i := 0; len(b_found) < max_pairs; i++ {

		a = a * a_factor % divisor
		b = b * b_factor % divisor

		if a % 4 == 0 {
			a_found = append(a_found, a)
		}

		if b % 8 == 0 {
			b_found = append(b_found, b)
		}

	}

	matching_pairs = judge(a_found, b_found)

	fmt.Println(matching_pairs)

}

func pad(binary string) string {
	current := len(binary)
	for i := 0; i<32-current;i++ {
		binary = "0"+binary
	}
	return binary
}

func judge(a_found []int, b_found []int) int {

	matches := 0
	count := len(b_found)

	for i := 0; i < count; i++ {

		a_padded := pad(strconv.FormatInt(int64(a_found[i]), 2))
		b_padded := pad(strconv.FormatInt(int64(b_found[i]), 2))

		if a_padded[16:] == b_padded[16:] {
			matches++
		}

	}

	return matches

}