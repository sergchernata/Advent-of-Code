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

func main() {

	// start at 1 because "0" aka start is included by default
	var severity = 0
	var layers = make(map[int]int)
	var highest = 0
	var scanner = 0
	var delay = 0 

	dat, err := ioutil.ReadFile("13_input.txt")
	check(err)

	// split input
	data := strings.Split(string(dat), "\n")

	// parse the data
	for _, d := range data {

		split := strings.Split(d, ": ")
		layer_depth,_ := strconv.Atoi(split[0])
		layer_range,_ := strconv.Atoi(split[1])
		layers[layer_depth] = layer_range

		if layer_depth > highest {
			highest = layer_depth
		}

	}

	// find the smallest possible delay
	// that gets us across without increasing severity
	for true {
		temp := traverse(layers, highest, delay, scanner)
		fmt.Println(delay)
		if temp == 0 {
			break
		}
		delay++
	}

	severity = traverse(layers, highest, 0, scanner)

	fmt.Println(delay)
	fmt.Println(severity)

}

func traverse(layers map[int]int, highest int, delay int, scanner int) int {

	var severity = 0

	for i := 0; i <= highest; i++ {

		if _, exists := layers[i-delay]; exists {

			if i < layers[i-delay] {
				scanner = i
			} else {
				scanner = i % (layers[i-delay] - 1)
			}
			
			if scanner == 0 {
				severity += i * layers[i-delay]
			}

		}

	}

	return severity

}