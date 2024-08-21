package main

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(600, 600, "3d cube")
    defer rl.CloseWindow()

    for !rl.WindowShouldClose() {
        // update

        // draw
        rl.BeginDrawing()

        defer rl.EndDrawing()
    }
}