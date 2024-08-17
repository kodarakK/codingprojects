package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

// Main stuff

UpdateDrawFrame :: proc() {

	frametime: f32 = rl.GetFrameTime()
	time: f32 = cast(f32)rl.GetTime()

	for i in 0 ..< MAX_ASTEROIDS {

		AsteroidUpdate(&_asteroids[i], frametime, time)
	}

	if time > _lastAsteriodCreationTime + ASTERIOD_DELAY {

		nextSize: AsteroidSize = _sizes[rl.GetRandomValue(0, 2)]

		AddAsteroid(GetNextAsteroidPosition(), cast(rl.Vector2){200, 0}, nextSize)

		_lastAsteriodCreationTime = time
	}

	if rl.IsKeyPressed(rl.KeyboardKey.GRAVE) {
		_showDebugMenu = !_showDebugMenu
	}

	rl.BeginDrawing()
	defer rl.EndDrawing()

	rl.ClearBackground(NEARBLACK)

	for i in 0 ..< MAX_ASTEROIDS {
		AsteroidDraw(_asteroids[i])
	}

	if _showDebugAngle {
		rl.DrawLineV(line0[0], line0[1], rl.RED)
		rl.DrawLineV(line1[0], line1[1], rl.BLUE)
	}

	if _showAsteroidCount {
		count: int = 0
		for i in 0 ..< MAX_ASTEROIDS {
			if (_asteroids[i].active) {
				count += 1
			}
		}

		rl.DrawRectangle(10, 10, 100, 52, rl.Fade(rl.BLACK, 0.6))
		rl.DrawText(rl.TextFormat("ASTERIODS: %d", count), 20, 20, 32, rl.WHITE)
	}

	if _showDebugMenu {
		r: rl.Rectangle = {10, cast(f32)screenHeight - 100, 180, 80}
		if rl.GuiButton(r, "Show Asteriod Count") {
			_showAsteroidCount = !_showAsteroidCount
		}

		r.x += 180 + 10
		if rl.GuiButton(r, "Show Asteriod Cone") {
			_showDebugAngle = !_showDebugAngle
		}

		// 	r: rl.Rectangle = {10, cast(f32)screenHeight - 100, 180, 80}
		// 	_showAsteroidCount = cast(bool)rl.GuiToggle(r, "Show Asteriod Count", &_showAsteroidCount)

		// 	r.x += 180 + 10
		// 	_showDebugAngle = cast(bool)rl.GuiToggle(r, "Show Asteriod Cone", &_showDebugAngle)
		// r: rl.Rectangle = {10, cast(f32)screenHeight - 60, 40, 40}
		// _showAsteroidCount = rl.GuiCheckBox(r, "Show Asteriod Count", &_showAsteroidCount)

		// r.y -= 30
		// _showDebugAngle = rl.GuiCheckBox(r, "Show Asteriod Cone", &_showDebugAngle)


	}


}

main :: proc() {

	rl.InitWindow(screenWidth, screenHeight, "Raylib Astereoids by CCR")
	defer rl.CloseWindow()

	for !rl.WindowShouldClose() {
		UpdateDrawFrame()
	}

}
