package main

import (
	"fmt"
	"io/ioutil"
	"sort"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	var checksum = 0

	dat, err := ioutil.ReadFile("2_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\t")

	// convert input
	for _, v := range lines {

		var digits []int

		// split into individual characters
		characters := strings.Split(v, "")

		// convert characters into digits
		for c := range characters {
			digit, _ := strconv.Atoi(characters[c])
			digits = append(digits, digit)
		}

		sort.Ints(digits)
		checksum += digits[len(digits)-1] - digits[0]

	}

	fmt.Println(checksum)
}
