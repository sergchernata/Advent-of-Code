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

func is_int(char string) (int, bool) {
	if v, e := strconv.Atoi(char); e == nil {
	    return v, true 
	}

	return 0, false
}

func main() {

	var frequency = 0
	var registers = make(map[string]int)

	dat, err := ioutil.ReadFile("18_input.txt")
	check(err)

	// split input
	instructions := strings.Split(string(dat), "\n")
	rewind := 0

	// parse the data
	Loop:
	for i := 0; i < len(instructions); i++ {

		if rewind > 0 {
			i = rewind
			rewind = 0
		}

		parts := strings.Split(instructions[i], " ")
		value := 0

		switch parts[0] {

			case "snd":
				frequency = registers[parts[1]]

			case "set":
				if number, is := is_int(parts[2]); is {
					registers[parts[1]] = number
				} else {
					registers[parts[1]] = registers[parts[2]]
				}

			case "add":
				if number, is := is_int(parts[2]); is {
					value = number
				} else {
					value = registers[parts[2]]
				}

				registers[parts[1]] += value

			case "mul":
				if number, is := is_int(parts[2]); is {
					value = number
				} else {
					value = registers[parts[2]]
				}

				registers[parts[1]] *= value

			case "mod":
				if number, is := is_int(parts[2]); is {
					value = number
				} else {
					value = registers[parts[2]]
				}

				registers[parts[1]] = registers[parts[1]] % value

			case "rcv":
				if registers[parts[1]] != 0 {
					registers[parts[1]] = frequency
					if frequency != 0 {
						break Loop
					}
				}

			case "jgz":
				if number, is := is_int(parts[2]); is {
					value = number
				} else {
					value = registers[parts[2]]
				}

				if registers[parts[1]] > 0 {
					rewind = i + value
				}


			default:
				fmt.Println("should never happen", i)

		}

	}

	fmt.Println(frequency, registers)

}