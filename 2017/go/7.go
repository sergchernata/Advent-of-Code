package main

import (
	"fmt"
	"io/ioutil"
	//"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	var tower = make(map[string][]string)
	//var total = 0

	dat, err := ioutil.ReadFile("7_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")
	//total = len(lines) - 1

	// parse the data and format it
	for _, v := range lines {

		if strings.Contains(v, " -> ") {

			split := strings.Split(v, " -> ")
			tower[strings.Split(split[0], " ")[0]] = strings.Split(split[1], ", ")

		}

	}

	// find the unique key, not referred by anyone else
	for program, _ := range tower {

		for _, v := range tower {

			if v[program] != "" {
				delete(tower, program)
			}

		}

	}

	fmt.Println(tower)

}
