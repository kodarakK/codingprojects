package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

main :: proc() {
     	WindowWidth: i32 : 600
     	WindowHeight: i32 : 400
	w: i32: 10
	rl.InitWindow(WindowWidth, WindowHeight, "Falling Sand")

	cols:i32: WindowWidth / w
	rows:i32: WindowHeight / w
	grid: [cols][rows]i32

	for i in 0..<cols {
	    for j in 0..<rows {
	    	grid[i][j] = 0
	    	x:i32= i * w
	    	y:i32= j * w
		fmt.printf("i: %d, j: %d, x: %d, y: %d\n",i,j,x,y)
	    }
	}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

	for i:i32=0;i<cols;i+=1 {
	    for j:i32=0;j<rows;j+=1 {
	    	x:i32= i * w
	    	y:i32= j * w
		rl.DrawRectangleLines(x, y, x+w, y+w, rl.DARKBLUE)
	    }
	}


		rl.ClearBackground(rl.RAYWHITE)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
