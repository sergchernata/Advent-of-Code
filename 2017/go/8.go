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

	var registers = make(map[string]int)
	var highest = 0

	dat, err := ioutil.ReadFile("8_input.txt")
	check(err)

	// split input
	lines := strings.Split(string(dat), "\n")

	// parse the data and format it
	for _, v := range lines {

		line := strings.Split(v, " ")

		if _, ok := registers[line[4]]; !ok {

			registers[line[4]] = 0

		}

		if _, ok := registers[line[0]]; !ok {

			registers[line[0]] = 0

		}

		number, _ := strconv.Atoi(line[6])
		is_true := false

		switch line[5] {

			case ">":
				is_true = registers[line[4]] > number

			case "<":
				is_true = registers[line[4]] < number
			
			case "==":
				is_true = registers[line[4]] == number

			case "!=":
				is_true = registers[line[4]] != number

			case "<=":
				is_true = registers[line[4]] <= number

			case ">=":
				is_true = registers[line[4]] >= number
				fmt.Println(registers[line[4]], number)

			default:
				fmt.Println("should never happen", line[5])

		}

		if is_true {

			change, _ := strconv.Atoi(line[2])

			if line[1] == "inc" {
				registers[line[0]] += change
			} else {
				registers[line[0]] -= change
			}

			if registers[line[0]] > highest {
				highest = registers[line[0]]
			}

		}

	}

	fmt.Println(registers, highest)

}