package main

import (
	"fmt"
	"math"
	"strconv"
)

const input int = 277678

func main() {

	//part_a()
	part_b()

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

func part_b() {

	var squares = make(map[string]int)
	var coil, x, y = 0, 0, 0
	var side_length, half_side, last = 1, 1, 1
	var x_dec, y_dec, x_inc, y_inc string
	
	squares["0,0"] = 1

	for last < input * 2 {

		half_side = (side_length - 1) / 2
		sum := 0

		// we need to make these into strings for concatenation
		x_dec = strconv.Itoa(x - 1)
		y_dec = strconv.Itoa(y - 1)
		x_inc = strconv.Itoa(x + 1)
		y_inc = strconv.Itoa(y + 1)
		
		// counter clockwise, 
		// from the position of 3 o'clock
		// golang returns 0 when trying to access a non-existing key
		// thus, we can simply add all possibilities
		if y ==  -1 * half_side && x == half_side { // begin a new coil
			fmt.Println("bottom right corner, new coil")
			coil += 1
			side_length += 2
			sum = squares[x_dec + "," + y_inc] + squares[strconv.Itoa(x) + "," + y_inc]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			x += 1

		} else if y < half_side && x ==  half_side { // side 1
			fmt.Println("right side")

			sum = squares[x_dec + "," + strconv.Itoa(y)] + squares[x_dec + "," + y_inc] + squares[x_dec + "," + y_dec]
			
			// on very first coil expansion "last" variable points
			// to the same value as one of the potential parts of "sum"
			// thus, we need to ignore that duplicate value
			if squares[x_dec + "," + strconv.Itoa(y)] == last {
				squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = sum
			} else {
				squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			}
			
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			y += 1
		
		} else if y == half_side && x == half_side { // top right corner
			fmt.Println("top right corner")
			sum = squares[x_dec + "," + y_dec]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			x -= 1
			

		} else if y == half_side && x >  -1 * half_side { // side 2
			fmt.Println("top side")
			sum = squares[strconv.Itoa(x) + "," + y_dec] + squares[x_dec + "," + y_dec] + squares[x_inc + "," + y_dec]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			x -= 1

		} else if y == half_side && x == -1 * half_side { // top left corner
			fmt.Println("top left corner")
			sum = squares[x_inc + "," + y_dec]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			y -= 1
			
		}else if x ==  -1 * half_side && y > -1 * half_side { // side 3
			fmt.Println("left side")
			sum = squares[x_inc+ "," + strconv.Itoa(y)] + squares[x_inc + "," + y_dec] + squares[x_inc + "," + y_inc]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			y -= 1

		} else if y == -1 * half_side && x == -1 * half_side { // bottom left corner
			fmt.Println("bottom left corner")
			sum = squares[x_inc + "," + y_inc]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			x += 1
			
		} else if y ==  -1 * half_side && x < half_side { // side 4
			fmt.Println("bottom side")
			sum = squares[strconv.Itoa(x) + "," + y_inc] + squares[x_dec + "," + y_inc] + squares[x_inc + "," + y_inc]
			squares[strconv.Itoa(x) + "," + strconv.Itoa(y)] = last + sum
			last = squares[strconv.Itoa(x) + "," + strconv.Itoa(y)]
			x += 1

		}

	}

	fmt.Println(squares)
}
