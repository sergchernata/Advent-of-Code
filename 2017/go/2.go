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
	lines := strings.Split(string(dat), "\n")

	// convert input
	for _, line := range lines {

		var numbers []int

		// split into individual characters
		number_strings := strings.Split(line, "\t")

		for _, v := range number_strings {
			converted, _ := strconv.Atoi(v)
			numbers = append(numbers, converted)
		}

		sort.Ints(numbers)

		checksum += numbers[len(numbers)-1] - numbers[0]

	}

	fmt.Println(checksum)
}
