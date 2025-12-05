package main

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:math"
import "core:sort"
import "core:slice"

read_full_file :: proc(filepath: string) -> []u8 {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok { fmt.println("error")}
    return data
}

contains_int :: proc(arr: []int, val: int) -> bool {
    for v in arr {
        if v == val {
            return true
        }
    }
    return false
}

main :: proc() {
    data:  = string(read_full_file("input2.txt"))
    ranges: [dynamic]stringnn
    for line in strings.split_lines_iterator(&data) {
        if len(line) == 0 { break }
        append(&ranges, line)
    }
    
    /*

lowers.sort()

uppers.sort()

total = uppers[-1] - lowers[0]

for i in range(1, len(lowers)):

diff = lowers[i] - uppers[i-1] - 1

if diff > 0: total -= DIFF
*/

    // lower : [dynamic]int
    // upper : [dynamic]int
    // for range_str in ranges {
    //     parts := strings.split(range_str, "-")
    //     range_l, _ := strconv.parse_int(parts[0])
    //     range_r, _ := strconv.parse_int(parts[1])
    //     append(&lower, range_l)
    //     append(&upper, range_r)
    // }
    // slice.sort(lower[:])
    // slice.sort(upper[:])
    // total := upper[len(upper) - 1] - lower[0]
    // for i:=1;i<len(lower)-1;i+=1 {
    //     diff := lower[i] - upper[i-1] -1
    //     if diff > 0 {total -=diff}
    // }

    lower :[dynamic]int
    upper :[dynamic]int
    for range_str in ranges {
        parts := strings.split(range_str, "-")
        range_l, _ := strconv.parse_int(parts[0])
        range_r, _ := strconv.parse_int(parts[1])
        append(&lower, range_l)
        append(&upper, range_r)
    }

    slice.sort(lower[:])
    slice.sort(upper[:])

    total := upper[len(upper) - 1] - lower[0]

    for i:=1;i<len(lower);i+=1 {
        diff := lower[i] - upper[i-1] - 1
        if diff > 0 {total -= diff }
    }

    fmt.println(total+1)
}
