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

	var programs = []string{"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"}
	var final_standing = ""
	
	dat, err := ioutil.ReadFile("16_input.txt")
	check(err)

	moves := strings.Split(string(dat), ",")

	for _, m := range moves {

		switch m[0:1] {

			case "s":
				spin,_ := strconv.Atoi(m[1:])
				temp := make([]string, len(programs))
				copy(temp, programs)
				current := 0

				for i := 0; i < len(programs); i++ {

					if current - spin < 0 {
						temp[current] = programs[len(programs ) - abs((current - spin) % len(programs ))]
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

	// knojlgibmdfehacp
	final_standing = strings.Join(programs,"")

	fmt.Println(final_standing)

}