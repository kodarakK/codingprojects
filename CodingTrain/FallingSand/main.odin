package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

WindowWidth: i32 : 600
WindowHeight: i32 : 400
w: i32: 10
rows:i32: WindowWidth / w
cols:i32: WindowHeight / w
grid: [cols][rows]i32


main :: proc() {
	rl.InitWindow(WindowWidth, WindowHeight, "Falling Sand")
	defer rl.CloseWindow()

	for i in 0..<cols {
	    for j in 0..<rows {
	    	grid[i][j] = 0
	    }
	}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()
            for i in 0..<cols {
                rl.DrawLine(0, i*w, 0, WindowHeight, rl.BLACK)
            }
	}

}
