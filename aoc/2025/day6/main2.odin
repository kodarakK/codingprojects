package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:strconv"
import "core:strings"

read_full_file :: proc(filepath: string) -> []u8 {
	data, ok := os.read_entire_file(filepath, context.allocator)
	if !ok {fmt.println("error")}
	return data
}

main :: proc() {
	input := string(read_full_file("input.txt"))

	rows: [dynamic]string
	for line in strings.split_lines_iterator(&input) {
		append(&rows, line)
	}

	cols: [dynamic][dynamic]string
	prob_index: int = 0
	for i := 0; i <= len(rows[4]) - 1; i += 1 {
		str: string = ""
		str = fmt.tprint(str, string(rows[0][i]))
		str = fmt.tprint(str, string(rows[1][i]))
		str = fmt.tprint(str, string(rows[2][i]))
		str = fmt.tprint(str, string(rows[3][i]))

		fmt.println(string(str))
	}


}
