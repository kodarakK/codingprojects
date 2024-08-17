package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

_player: Player = {
	position = screenCenter,
	rotation = 0, 
	velocity = {0, 0},
}


main :: proc() {
	rl.InitWindow(screenWidth, screenHeight, "Raylib Astereoids by CCR")
	defer rl.CloseWindow()

	for !rl.WindowShouldClose() {
		UpdateDrawFrame()
	}
}

UpdateDrawFrame :: proc() {
	activeAsteroids: int = UpdateAsteroids()
	PlayerUpdate(&_player)


	rl.BeginDrawing()
	defer rl.EndDrawing()

	rl.ClearBackground(NEARBLACK)
	// DrawAsteroids()
	PlayerDraw(_player)
	ShowDebugVisualisation(activeAsteroids)
	ShowDebugMenu()
}