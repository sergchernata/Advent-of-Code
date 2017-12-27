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

func str_to_int(digits []string) map[int]int {
	var ints = make(map[int]int)

	for k,v := range digits {
		converted, _ := strconv.Atoi(strings.Replace(v, " ", "", -1))
		ints[k] = converted
	}

	return ints
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {

	var closest_particle = 0
	var closest_distance = 0
	var grid = make(map[int]map[string]map[int]int)

	dat, err := ioutil.ReadFile("20_input.txt")
	check(err)

	particles := strings.Split(string(dat), "\n")
	loops := 1000

	for k,v := range particles {
		parts := strings.Split(v, ", ")
		p := parts[0][3:len(parts[0]) - 1]
		v := parts[1][3:len(parts[1]) - 1]
		a := parts[2][3:len(parts[2]) - 1]

		slice := make(map[string]map[int]int)

		slice["p"] = str_to_int(strings.Split(p, ","))
		slice["v"] = str_to_int(strings.Split(v, ","))
		slice["a"] = str_to_int(strings.Split(a, ","))
		
		grid[k] = slice
	}

	for i := 0; i < loops; i++ {

		for k, _ := range grid {

			grid[k]["v"][0] += grid[k]["a"][0]
			grid[k]["v"][1] += grid[k]["a"][1]
			grid[k]["v"][2] += grid[k]["a"][2]

			grid[k]["p"][0] += grid[k]["v"][0]
			grid[k]["p"][1] += grid[k]["v"][1]
			grid[k]["p"][2] += grid[k]["v"][2]

			sum := abs(grid[k]["p"][0]) + abs(grid[k]["p"][1]) + abs(grid[k]["p"][2])

			if sum < closest_distance || closest_distance == 0 {
				closest_distance = sum
				closest_particle = k
			}

		}

	}
	// 400 too high
	// 329, 330 too low

	fmt.Println(closest_particle)

}