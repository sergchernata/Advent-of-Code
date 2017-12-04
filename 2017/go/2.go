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

		// split into individual characters
		characters := strings.Split(v, "")

		sort.Strings(characters)
		lowest, _ := strconv.Atoi(characters[0])
		highest, _ := strconv.Atoi(characters[len(characters)-1])

		checksum += highest - lowest

	}

	fmt.Println(checksum)
}
