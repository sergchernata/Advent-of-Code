package main

import (
	"fmt"
	"strconv"
	"strings"
)

var input string = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
var list_size = 255

// var input string = "3,4,1,5"
// var list_size = 5

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

	new_numbers := make([]int, len(numbers))
	copy(new_numbers, numbers)
	size := list_size - 1
	a := position
	b := (position + length - 1) % size

	for i := length; i > 0; i-- {

		if a > size {
			a = 0
		}

		if b < 0 {
			b = size
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

	// parse the data and format it
	for _, l := range lengths {

		length,_ := strconv.Atoi(l)

		if length > 1 {
			numbers = reverseSlice(position, length, numbers)
		}

		if position + length + skip_size < list_size - 1 {
			position = position + length + skip_size
		} else if position + length + skip_size > list_size - 1 {
			position = (position + length + skip_size) % list_size
		}
fmt.Println(position, length, skip_size, list_size)
		skip_size++
//fmt.Println(numbers)
	}

	part_a := numbers[0] * numbers[1]

	fmt.Println(part_a)

}