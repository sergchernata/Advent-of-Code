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

	var valid = 0

	dat, err := ioutil.ReadFile("4_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")

	// process each passphrase
	Pass:
	for _, line := range lines {

		words := strings.Split(line, " ")
		encountered := make(map[string]bool)

		// check for duplicates
		for _, word := range words {
			if encountered[word] == true {
				continue Pass
			} else {
				encountered[word] = true
			}
		}

		valid += 1
	}

	fmt.Println(valid)
}
