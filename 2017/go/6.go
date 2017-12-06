package main

import (
	"fmt"
	"strings"
	"strconv"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

var input = "14	0	15	12	11	11	3	5	1	6	8	4	9	1	8	4"

func main() {

	var cycles = 0
	var configs = make(map[string]bool)
	var last_config string
	var converted []int
	var length = 0

	numbers := strings.Split(input, "\t")
	length = len(numbers) - 1

	// convert into a numbered array of ints
	for _,v := range numbers {
		to_int, _ := strconv.Atoi(v)
		converted = append(converted, to_int)
	}

	for true {

		biggest_k := 0
		biggest_v := 0
		
		// find the largest value and associated key
		for k,v := range converted {
			if v > biggest_v {
				biggest_k = k
				biggest_v = v
			}
		}

		// wipe the biggest key
		// before we redistribute it's value
		converted[biggest_k] = 0

		// begin redistribution
		for biggest_v > 0 {

			if biggest_k == length {
				biggest_k = 0
			} else {
				biggest_k += 1
			}

			converted[biggest_k] += 1
			biggest_v -= 1

		}

		// record new configuration
		last_config = ""

		for k,v := range converted {
			last_config += strconv.Itoa(v)
			if k != len(converted) {
				last_config += " "
			}
		}

		cycles += 1

		// check if new config has been seen before
		if configs[last_config] {
			break
		} else {
			configs[last_config] = true
		}

	}

	fmt.Println(cycles)
}