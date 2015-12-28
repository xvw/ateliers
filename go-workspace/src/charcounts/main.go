package main

import (
	"fmt"
	"os"
	"strings"
)

func Analysis(str string) map[rune]int {
	result := make(map[rune]int)
	for _, rune := range str {
		result[rune] += 1
	}
	return result
}

func Report(result map[rune]int) {
	for rune, total := range result {
		fmt.Printf("%c : %d \n", rune, total)
	}
}

func main() {

	args := os.Args[1:]
	str := strings.Join(args, " ")
	fmt.Printf("In : [%s]\n", str)
	Report(Analysis(str))
}
