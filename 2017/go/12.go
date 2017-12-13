package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

var total = 0
var programs = make(map[string][]string)
var seen = make(map[string]bool)
var start = "0"

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func traverse(start string) {

	for k,v := range programs {

		if k == start {

			seen[k] = true
			to_add := len(v)

			for _, p := range v {
				if seen[p] {
					to_add--
				}
			}

			total += to_add

			for _, p := range v {
				if !seen[p] {
					seen[p] = true
					traverse(p)
				}
			}

		}

	}

}

func main() {

	dat, err := ioutil.ReadFile("12_input.txt")
	check(err)

	// split input
	data := strings.Split(string(dat), "\n")

	// parse the data
	for _, d := range data {

		split := strings.Split(d, " <-> ")
		comms := strings.Split(split[1], ", ")
		programs[split[0]] = comms

	}

	// 262 too high
	// 133 too low
	traverse(start)

	fmt.Println(total)

}