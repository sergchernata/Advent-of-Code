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

func find_difference(numbers []int) int {
	// start with the highest number
	for i := len(numbers) - 1; i >= 0; i-- {
		//divided by the lowest
		for _, v := range numbers {
			// make sure we don't divide a number by itself
			// giving a false positive
			if (numbers[i] != v) && numbers[i]%v == 0 {
				return numbers[i] / v
			}
		}
	}
	return 0
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

		// part A
		//checksum += numbers[len(numbers)-1] - numbers[0]

		// part B
		checksum += find_difference(numbers)

	}

	fmt.Println(checksum)
}
