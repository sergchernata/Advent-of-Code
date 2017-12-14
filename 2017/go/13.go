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


	for i := 0; i <= highest; i++ {

		fmt.Println(i, scanner)

		if _, exists := layers[i]; exists {

			if i == 0 || scanner == 0 {

				severity += i * layers[i]

			}

			

			if i < layers[i] {
				scanner = i
			} else {
				scanner = i % (layers[i] - 1)
			}

		}

		fmt.Println(i, scanner)
		fmt.Println("----")

	}

	fmt.Println(severity)

}