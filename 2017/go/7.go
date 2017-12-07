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

	// map[tower][child]true
	var tower = make(map[string]map[string]bool)
	var top string

	dat, err := ioutil.ReadFile("7_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")

	// parse the data and format it
	for _, v := range lines {

		if strings.Contains(v, " -> ") {

			split := strings.Split(v, " -> ")
			children := strings.Split(split[1], ", ")
			parent := strings.Split(split[0], " ")[0]
			tower[parent] = make(map[string]bool)

			for _,c := range children {
				tower[parent][c] = true
			}

		}

	}

	// find the unique program, not referred by anyone else
	Loop:
	for program, _ := range tower {

		for _, v := range tower {

			if v[program] {
				continue Loop
			}

		}

		top = program

	}

	fmt.Println("A: ", top)

}
