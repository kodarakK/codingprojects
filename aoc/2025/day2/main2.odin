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

convert_str_to_int_dyn_array :: proc(arr: [dynamic]string) -> [dynamic]int {
    array: [dynamic]int
    for i := 0; i < len(arr); i += 1{
        el, _ := strconv.parse_int(arr[i])
        append_elem(&array, el)
    }
    return array
}

is_invalid :: proc (el: int) -> bool {
    // // chop in halve, check if same => valid id, not good for part 2
    number: string = fmt.tprint(el)
    
    // check hoeveel keer een char voorkomt
}

give_invalids :: proc (el1: int, el2: int) -> [dynamic]int {
    invalids: [dynamic]int
    for i:=el1;i<el2;i+=1 {
        if is_invalid(i) { append_elem(&invalids, i) }
    }
    return invalids
}

main :: proc () {
    data := string(read_full_file("input.txt"))

    ranges: []string = strings.split(data, ",")
    ranges_split: [dynamic]string
    
    for line in ranges {
        for str in strings.split(line, "-") {
            append(&ranges_split, str)            
        }
    }

    ranges_split_int: [dynamic]int = convert_str_to_int_dyn_array(ranges_split)

    invalid_id: [dynamic]int

    for i:=0;i<len(ranges_split_int);i+=2 {
        append_elems(&invalid_id, ..give_invalids(ranges_split_int[i], ranges_split_int[i+1])[:])
    }

    total: int = 0
    for el in invalid_id {
        total += el
    }

    fmt.println(total)
}
