package main

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:math"

MOD_NUM :: 100

mod :: proc(n: int) -> int {
    return ((n % MOD_NUM) + MOD_NUM) % MOD_NUM
}

read_full_file :: proc(filepath: string) -> []u8 {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok { fmt.println("error")}
    return data
}

rotate :: proc(dir: string, n: int, l: int) -> int {
    lock := l
    if strings.compare(dir, "L") == 0 {
        lock = mod(lock - n)
    }
    else {
        lock = mod(lock + n)
    }

     return lock
}

execute :: proc() {
    data := string(read_full_file("./input.txt"))

    lock: int = 50
    count: int = 0

    for line in strings.split_lines_iterator(&data){
        sub, _   : = strings.substring_to(line, 1)
        n, _     := strings.substring_from(line, 1)
        n_int, _ := strconv.parse_int(n)
        lock      = rotate(sub, n_int, lock)
        
        if lock == 0 { count += 1 }
    }
    
    fmt.println(count)
}

main :: proc() {
    execute()
}
