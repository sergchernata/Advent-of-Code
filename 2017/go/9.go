package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	var skip = false
	var garbage = false
	var to_add = 0
	var score = 0
	var nest = -1
	var non_canceled = 0

	dat, err := ioutil.ReadFile("9_input.txt")
	check(err)

	// split input
	chars := strings.Split(string(dat), "")

	// parse the data
	for _, c := range chars {

		if skip {
			skip = false
			continue
		}

		if c == "!" {
			skip = true
			continue
		}

		if garbage && c != ">" {
			non_canceled += 1
		}

		if c == "<" {
			garbage = true
		}

		if c == ">" {
			garbage = false
			skip = false
		}

		if garbage {
			continue
		}

		if c == "{" {
			nest += 1
			to_add += nest + 1
			continue
		} else if c == "}" {
			nest -= 1
			// check nesting level
			if nest == -1 {
				score += to_add
				to_add = 0
			}
			continue
		}

	}

	fmt.Println(score, non_canceled)

}