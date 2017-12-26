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

	var letters = ""
	var x = 1
	var y = 0
	var down = true
	var right = true
	var direction = "|"
	var count = 0
	var grid = make(map[int][]string)

	dat, err := ioutil.ReadFile("19_input.txt")
	check(err)

	path := strings.Split(string(dat), "\n")
	for k,v := range path {
		grid[k] = strings.Split(v, "")
	}

	for true {

		current := grid[y][x]

		if current == " "{
			break
		}

		if (current == "|" || current == "-") && direction == "|" {

			if down {
				y++
			} else {
				y--
			}

		} else if (current == "|" || current == "-") && direction == "-" {

			if right {
				x++
			} else {
				x--
			}

		} else if current == "+" {

			if direction == "|" { // vertical
				
				possible := (x - 1) < len(grid[y])

				if possible && grid[y][x - 1] != " " {
					x--
					right = false
				} else {
					x++
					right = true
				}

				direction = "-"

			} else { // horizontal

				possible := (y + 1) < len(grid)

				if possible && grid[y + 1][x] != " " {
					down = true
					y++
				} else {
					y--
					down = false
				}

				direction = "|"

			}

		} else {

			letters += current

			if direction == "|" { // vertical
				
				if down {
					y++
				} else {
					y--
				}

			} else if direction == "-" { // horizontal

				if right {
					x++
				} else {
					x--
				}
				
			}

		}

		count++

	}

	fmt.Println(letters, count)

}