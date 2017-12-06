package main

import (
	"fmt"
	"io/ioutil"
	"sort"
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

			word = SortString(word)
			
			if encountered[word] {
				continue Pass
			} else {
				encountered[word] = true
			}
		}

		valid += 1
	}

	fmt.Println(valid)
}

func SortString(word string) string {
    characters := strings.Split(word, "")
    sort.Strings(characters)
    return strings.Join(characters, "")
}