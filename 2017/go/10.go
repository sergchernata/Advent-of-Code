package main

import (
	"fmt"
	"strconv"
	"strings"
)

var input string = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
var list_size = 255

// var input string = "3,4,1,5"
// var list_size = 4

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func makeList(size int) []int {
    a := make([]int, size+1)
    for i := range a {
        a[i] = i
    }
    return a
}

func reverseSlice(position int, length int, numbers []int) []int {
fmt.Println("Position:", position, "Length:", length)
	new_numbers := make([]int, len(numbers))
	copy(new_numbers, numbers)
	size := list_size - 1
	a := position
	var b int

	if position + length < list_size {
		b = position + length - 1
	} else {
		b = (position + length) % size
	}
	
fmt.Println("A:", a, "B:", b)
	for i := length; i > 0; i-- {

		if a > list_size {
			a = 0
		}

		if b < 0 {
			b = list_size
		}

		new_numbers[a] = numbers[b]
		new_numbers[b] = numbers[a]
		a++
		b--

	}

	return new_numbers
}

func main() {

	// split input
	lengths := strings.Split(input, ",")
	numbers := makeList(list_size)

	var position = 0
	var skip_size = 0
// fmt.Println(numbers)
// fmt.Println(reverseSlice(216, 90, numbers))
	// parse the data and format it
	for _, l := range lengths {

		length,_ := strconv.Atoi(l)

		if length > 1 {
			numbers = reverseSlice(position, length, numbers)
		}
// fmt.Println("Position: ", position)
// fmt.Println("Length: ", length)
// fmt.Println("End: ", list_size - (position + length))
// fmt.Println("Skip Size: ", skip_size)
// //fmt.Println("List Size: ", list_size)
fmt.Println(numbers)
		if position + length + skip_size < list_size {
			position = position + length + skip_size
		} else if position + length + skip_size > list_size {
			position = (position + length + skip_size - 1) % list_size
		}

		skip_size++
	}

	part_a := numbers[0] * numbers[1]

	//fmt.Println(numbers)
	fmt.Println(part_a)

}