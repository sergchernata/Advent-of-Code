package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	//"reflect"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	// map[tower][child]true
	var tower = make(map[string]map[string]bool)
	var weights = make(map[string]int)
	var top string

	dat, err := ioutil.ReadFile("7_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")

	// parse the data and format it
	// remove everything that doesn't have children
	for _, v := range lines {

		if strings.Contains(v, " -> ") {

			split := strings.Split(v, " -> ")
			children := strings.Split(split[1], ", ")
			parent := strings.Split(split[0], " ")[0]
			tower[parent] = make(map[string]bool)

			r := strings.NewReplacer("(", "", ")", "")
			weight_str := r.Replace(strings.Split(split[0], " ")[1])
			weight_int, _ := strconv.Atoi(weight_str)
			weights[parent] = weight_int

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

	// find the branch that has wrong eight
	// fmt.Println(reflect.TypeOf(tower[top]))
	check_weights(tower[top], weights, tower)

}

func check_weights(branch map[string]bool, weights map[string]int, tower map[string]map[string]bool) int {

	wrong_weight := 0

	// add weights on current branch

	// if we hit an uneven weight, terminate

	// if one of the children has children, recurse
	check_weights(tower[child], weights, tower)

	return wrong_weight

}
