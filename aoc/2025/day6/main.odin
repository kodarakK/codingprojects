package main

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:math"

read_full_file :: proc(filepath: string) -> []u8 {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok { fmt.println("error")}
    return data
}

main :: proc() {
    input:  = string(read_full_file("input.txt"))


    columns := make([dynamic][dynamic]string, 0)
    for line in strings.split_lines_iterator(&input) {
        fields := strings.fields(line)
        for i:=0; i<len(fields); i+=1 {
            if i>=len(columns) {
                append_elem(&columns, make([dynamic]string, 0))
            }
        }

        for val, i in fields {
            append_elem(&columns[i], val)
        }
    }
    full_total: int = 0
    counter: int = 0
    for row in columns {
        nums: [dynamic]int
        total: int = 1
        for val, i in row[:len(row)-1] {
            num, _ := strconv.parse_int(val)
            append(&nums, num)
        }
        for val, i in nums {
            if row[len(row)-1] == "*" {
                total *= val
            } else {
                total += val
                counter += 1
            }
        }
        if row[len(row)-1] == "+" {total -= 1}
        full_total += total
    }
    fmt.println(full_total)
}
