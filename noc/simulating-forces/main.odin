package odin

import "core:fmt" 
import rl "vendor:raylib"

screenWidth: i32 = 600
screenHeight: i32 = 450

Mover :: struct {
	position: rl.Vector2,
	velocity: rl.Vector2,
	acceleration: rl.Vector2,
}

UpdateMover :: proc(mover: ^Mover) {
	mover.velocity += mover.acceleration
	mover.position += mover.velocity
	mover.acceleration = rl.GetMousePosition() - mover.position
	mover.acceleration *= 0.0001
}

DrawMover :: proc(mover: Mover) {
	rl.DrawCircle(cast(i32)mover.position.x, cast(i32)mover.position.y, 32, rl.WHITE)
}

main :: proc() {
	rl.InitWindow(screenWidth, screenHeight, "simulating forces - Gravity and Wind")
	defer rl.CloseWindow()

	mover: Mover = {
		position = {10, 10},
		velocity = {cast(f32)rl.GetRandomValue(0, 5), cast(f32)rl.GetRandomValue(0, 5)},
		acceleration = {0, 0}
	}
	
	for !rl.WindowShouldClose() {
		// update
		UpdateMover(&mover)

		// draw
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.BLACK)
		DrawMover(mover)
	}

}