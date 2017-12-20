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

func abs(x int) int {
	if x < 0 {
		return -x
	}
	if x == 0 {
		return 0
	}
	return x
}

func main() {

	var initial_state = map[string]int{"a":0,"b":1,"c":2,"d":3,"e":4,"f":5,"g":6,"h":7,"i":8,"j":9,"k":10,"l":11,"m":12,"n":13,"o":14,"p":15}
	var programs = []string{"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"}
	var billion_dances = make([]string, len(programs))
	var template = make(map[int]int)
	var single_cycle = ""
	var billion_cycles = ""
	
	dat, err := ioutil.ReadFile("16_input.txt")
	check(err)

	moves := strings.Split(string(dat), ",")

	programs = dance(programs, moves)
	copy(billion_dances, programs)

	template = get_end_state(programs, initial_state)

	for i := 0; i < 999999999; i++ {
		temp := make([]string, len(programs))

		for k,v := range template {
			temp[v] = billion_dances[k]
		}

		billion_dances = temp
	}

	single_cycle = strings.Join(programs,"")
	billion_cycles = strings.Join(billion_dances,"")

	fmt.Println(single_cycle, billion_cycles)

}

func get_end_state(programs []string, initial_state map[string]int) map[int]int {

	var template = make(map[int]int)

	for k,v := range programs {
		template[initial_state[v]] = k
	}

	return template

}

func dance(programs []string, moves []string) []string {

	for _, m := range moves {

		switch m[0:1] {

			case "s":
				spin,_ := strconv.Atoi(m[1:])
				temp := make([]string, len(programs))
				copy(temp, programs)
				current := 0

				for i := 0; i < len(programs); i++ {

					if current - spin < 0 {
						temp[current] = programs[len(programs) - abs((current - spin) % len(programs ))]
					} else {
						temp[current] = programs[current - spin]
					}

					if current == len(programs) - 1 {
						current = 0
					} else {
						current++
					}

				}

				programs = temp

			case "x":
				split := strings.Split(m[1:],"/")
				a,_ := strconv.Atoi(split[0])
				b,_ := strconv.Atoi(split[1])
				temp := programs[a]
				programs[a] = programs[b]
				programs[b] = temp

			case "p":
				split := strings.Split(m[1:],"/")
				a_pos := 0
				b_pos := 0

				for i := 0; i < len(programs); i++ {

					if programs[i] == split[0] {
						a_pos = i
					}

					if programs[i] == split[1] {
						b_pos = i
					}

				}

				temp := programs[a_pos]
				programs[a_pos] = programs[b_pos]
				programs[b_pos] = temp

			default:
				fmt.Println("should never happen", m)
		}

	}

	return programs

}