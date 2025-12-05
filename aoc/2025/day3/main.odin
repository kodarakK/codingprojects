package main

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:math"
import "core:unicode/utf8"

read_full_file :: proc(filepath: string) -> []u8 {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok { fmt.println("error")}
    return data
}

get_biggest_number_pos :: proc(slice: string) -> int {
    max_num: int = 0
    pos_max: int = 0
    counter: int = 0
    for char in slice {
        r: []rune = []rune{char}
        s: string = utf8.runes_to_string(r)
        num, _ := strconv.parse_int(s)
        if num > max_num {
            max_num = num
            pos_max = counter
            fmt.printf("max: %d\n", max_num)
        }
        counter += 1
    }
    return pos_max
}

main :: proc() {
    data := string(read_full_file("./test_input.txt"))
    banks: [dynamic]string 
    for line in strings.split_lines_iterator(&data) {
        append(&banks, line)
    }
    for line in banks {
        max_pos := get_biggest_number_pos(line)
	prev_max_pos: int
	next_max_pos: int
        if max_pos == len(line) {
            prev_max_pos = get_biggest_number_pos(line[:max_pos])
	    fmt.println(line)
	    fmt.printf("getal: %s%s\n", utf8.runes_to_string(line[max_pos]), utf8.runes_to_string(line[prev_max_pos]))
        }
	else {
	     next_max_pos = get_biggest_number_pos(line[max_pos:])
	     fmt.println(line)
	     fmt.printf("getal: %s%s\n", utf8.runes_to_string(line[max_pos]), utf8.runes_to_string(line[prev_max_pos]))
	}	
    }
    // vind grootste getal
    // als die op het einde is :
    //    vind 2de grootste getal en pak de laaste getal
    // anders: check erachter voor het grootste getal
    // plak die samen, tel ze allemaal bij elkaar op
}
