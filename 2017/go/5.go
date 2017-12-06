package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"strconv"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	var steps = 0
	var done = false
	var current = 0
	var converted = make(map[int]int)
	var total = 0

	dat, err := ioutil.ReadFile("5_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")
	total = len(lines) - 1

	// convert strings to int
	for k,v := range lines {
		to_int, _ := strconv.Atoi(v)
		converted[k] = to_int
	}

	for done == false {

		// process the jump
		temp := current
		current += converted[current]

		if current > total {
			done = true
		}

		// part B if statement
		if converted[temp] >= 3 {
			converted[temp] -= 1
		} else {
			// only this line is needed
			// for part A
			converted[temp] += 1
		}

		steps += 1
	}

	fmt.Println(steps)
}

func Abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}