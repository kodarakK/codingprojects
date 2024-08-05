package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

main :: proc() {
     	WindowWidth: i32 : 600
     	WindowHeight: i32 : 400
	w: i32: 10
	rl.InitWindow(WindowWidth, WindowHeight, "Falling Sand")

	rows:i32: WindowWidth / w
	cols:i32: WindowHeight / w
	grid: [cols][rows]i32

	for i in 0..<cols {
	    for j in 0..<rows {
	    	grid[i][j] = 0
                fmt.println(i*w, j*w, i*w+w, j*w+w)
	    }
	}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

	for i in 0..<cols {
	    for j in 0..<rows {
                rl.DrawLine(i, j, rl.BLACK)
                rl.DrawLine(i+w, j+w, rl.BLACK)
	    }
	}


		rl.ClearBackground(rl.RAYWHITE)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
