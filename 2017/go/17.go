package main

import (
	"fmt"
	//"strings"
	//"strconv"
)

func main() {

	var step = 366
	var position = 0
	var value = 1
	var steps = []int{0}

	for len(steps) < 2018 {

		for i := 0; i < step; i++ {

			if position == len(steps) - 1 {
				position = 0
			} else {
				position++
			}

		}

		if len(steps) > 2016 {
			fmt.Println(steps[position+1])
		}

		steps = insert(steps, position + 1, value)
		position = position + 1

		value++

	}
	
}

func insert(original []int, position int, value int) []int {

	target := make([]int, len(original)+1)
	copy(target, original[:position])
	target[position] = value
	copy(target[position+1:], original[position:])

	return target
}