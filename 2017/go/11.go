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

func absMax(a, b int) int {
	a = abs(a)
	b = abs(b)
    if a > b {
        return a
    }
    return b
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

	var steps = 0
	var x = 0
	var y = 0
	var furthest = 0

	dat, err := ioutil.ReadFile("11_input.txt")
	check(err)

	// split input
	direction := strings.Split(string(dat), ",")

	// parse the data
	for _, d := range direction {

		switch d {

			case "n":
				y--

			case "ne":
				x++
				y--

			case "se":
				x++

			case "s":
				y++

			case "sw":
				y++
				x--

			case "nw":
				x--

			default:
				fmt.Println("should never happen", d)

		}

		max := absMax(y,x)

		if furthest < max {
			furthest = max
		}

	}

	steps = absMax(y,x)

	fmt.Println(steps, furthest)

}