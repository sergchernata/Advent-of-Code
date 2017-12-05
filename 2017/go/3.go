package main

import (
	"fmt"
	"math"
)

const input int = 277678

func main() {

	part_a()
	part_b()

}

func part_b() {

	squares = make(map[string]int)
	last, coil, x, y = 0
	side, current_coil, current_side, side_length = 1
	squares["0,0"] = 1

	for last <= input {

		// add +1 to x


		if y <  {

		} else if {

		} else { // begin a new coil
			coil += 1
			side_length += 2
			x += 1
		}

	}

}

func part_a() {

	var steps = 0
	var spirals int
	var x_length, y_length int

	// spiraling numerical grid
	// let's find out how many times it needs to spiral
	// in order to get to the input number
	var spirals_approx = math.Sqrt(float64(input))

	// determine the closest round number of spirals
	// add 0.5 before conversion because go has no native math.Round
	if spirals_approx-float64(int(spirals_approx)) < 0.5 {
		spirals = int(spirals_approx)
	} else {
		spirals = int(spirals_approx + 0.5)
	}

	// traveling up or down the spiral
	// depending on which is closer to our "spirals" count
	bottom_right_corner := spirals * spirals

	if input > bottom_right_corner {

	} else {

		bottom_left_corner := bottom_right_corner - spirals
		side_length := bottom_right_corner - bottom_left_corner
		side_half := (side_length - 1) / 2
		difference := bottom_right_corner - input
		y_length = side_half

		// our number is in the exact middle of it's side
		// in a straight line from origin
		if bottom_left_corner+side_half == input {

		} else if bottom_left_corner+side_half > input { // our number is to the left of side middle

		} else { // our number is to the right of side middle
			x_length = side_half - difference
		}

		// debug stuffs
		//fmt.Println(bottom_left_corner, difference, side_length, side_half, x_length, y_length)
	}

	steps = x_length + y_length

	fmt.Println(steps)

}
