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
    data:  = string(read_full_file("input.txt"))
    ranges: [dynamic]string
    nums: [dynamic]string
    for line in strings.split_lines_iterator(&data) {
        if len(line) == 0 { break }
        append(&ranges, line)
    }
    for line in strings.split_lines_iterator(&data) {
        if strings.contains(line, "-") { continue }
        if len(line) == 0 { continue }
        append(&nums, line)
    }
    counter: int = 0
    counted: bool = false
    for num in nums {
        counted = false
        for range in ranges {
            num, _ := strconv.parse_int(num) 
            
            range_l, _ := strconv.parse_int(strings.split(range, "-")[0])
            range_r, _ := strconv.parse_int(strings.split(range, "-")[1])
            // fmt.printf("onder range: %d\tnum: %d\tboven range: %d\n", range_l, num, range_r)
            
            if !counted &&  num >= range_l && num <= range_r {
                counter += 1
                counted = true
                break
            }  
        }
    }

    fmt.println(counter)
}
