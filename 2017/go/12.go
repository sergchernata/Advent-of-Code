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

	var total = 0
	var programs = make(map[string][]string)

	dat, err := ioutil.ReadFile("12_input.txt")
	check(err)

	// split input
	data := strings.Split(string(dat), ",")

	// parse the data
	for _, d := range data {

		split := strings.Split(d, " <-> ")
		comms := strings.Split(split[1], ", ")
		programs[split[0]] = comms

	}


	fmt.Println(total, programs)

}