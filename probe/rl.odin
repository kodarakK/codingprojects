package rl

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(600, 480, "testing");
	defer rl.CloseWindow()

	for (!rl.WindowShouldClose())
	{
		
	// draw loop
	rl.BeginDrawing();
	defer rl.EndDrawing();
	rl.ClearBackground(rl.BLUE)

}
}
