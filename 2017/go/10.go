package main

import (
	"fmt"
	"strconv"
	"strings"
)

var input string = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
var list_size = 256

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func makeRange(min, max int) []int {
    a := make([]int, max-min+1)
    for i := range a {
        a[i] = min + i
    }
    return a
}

func reverseSlice(position, length, numbers) []int {

	new_numbers = numbers

	for i := position; i < length; i++ {



	}

	return numbers
}

func main() {

	// split input
	lengths := strings.Split(input, ",")
	numbers := makeRange(0,255)

	//var registers = make(map[string]int)
	var position = 0
	var skip_size = 0


	// parse the data and format it
	for _, l := range lengths {

		length,_ := strconv.Atoi(l)

		if length > 1 {
			numbers = reverseSlice(position, length, numbers)
		}

		position = length + skip_size
		skip_size += 1

	}

	part_a := numbers[0] * numbers[1]

	fmt.Println(part_a)

}