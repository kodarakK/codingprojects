package main 

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

// DEBUG
_showDebugMenu: bool = false
_showDebugAngle: bool = false
_switchMenuStyle: bool = false
_debugUseCheckbox: bool = false
_showAsteroidCount: bool = false
line0: [2]rl.Vector2
line1: [2]rl.Vector2

//

ShowDebugMenu :: proc() {

	if rl.IsKeyPressed(rl.KeyboardKey.GRAVE) {
		_showDebugMenu = !_showDebugMenu
	}

    if _showDebugMenu {
        if !_debugUseCheckbox {

			r: rl.Rectangle = {10, cast(f32)screenHeight - 80, 180, 60}
			_showAsteroidCount = cast(bool)rl.GuiToggle(r, "Show Asteriod Count", &_showAsteroidCount)

			r.x += 180 + 10
			_showDebugAngle = cast(bool)rl.GuiToggle(r, "Show Asteriod Cone", &_showDebugAngle)

            r.x += 180 + 10
            if cast(bool)rl.GuiToggle(r, "Switch Menu Style", &_switchMenuStyle) {
                _debugUseCheckbox = !_debugUseCheckbox
            }
		}
        else {
            r: rl.Rectangle = {10, cast(f32)screenHeight - 40, 20, 20}
            _showAsteroidCount = rl.GuiCheckBox(r, "Show Asteroid Count", &_showAsteroidCount)
			
			r.y -= 30
			_showDebugAngle = rl.GuiCheckBox(r, "Show Angle Cone", &_showDebugAngle)

			r.y -= 30
			if rl.GuiCheckBox(r, "Switch Menu Style", &_switchMenuStyle) {
				_debugUseCheckbox = !_debugUseCheckbox
			}
        }
    }
}
ShowDebugVisualisation :: proc(asteroidCount: int) {

	if _showDebugAngle {
		rl.DrawLineV(line0[0], line0[1], rl.RED)
		rl.DrawLineV(line1[0], line1[1], rl.BLUE)
	}

	if _showAsteroidCount {
		// count: int = 0
		// for i in 0 ..< MAX_ASTEROIDS {
		// 	if (_asteroids[i].active) {
		// 		count += 1
		// 	}
		// }

		rl.DrawRectangle(10, 10, 100, 52, rl.Fade(rl.BLACK, 0.6))
		rl.DrawText(rl.TextFormat("ASTERIODS: %d", asteroidCount), 20, 20, 32, rl.WHITE)
	}
}

SetLastCone :: proc(position: rl.Vector2, velocity: rl.Vector2) {
	line0[0] = position
	line0[1] = position + rl.Vector2Rotate(velocity * 10, -ASTEROID_RANDOM_ANGLE)

	line1[0] = position
	line1[1] = position + rl.Vector2Rotate(velocity * 10, ASTEROID_RANDOM_ANGLE)
}

// 	if _showDebugMenu {
// 		r: rl.Rectangle = {10, cast(f32)screenHeight - 100, 180, 80}
// 		if rl.GuiButton(r, "Show Asteriod Count") {
// 			_showAsteroidCount = !_showAsteroidCount
// 		}

// 		r.x += 180 + 10
// 		if rl.GuiButton(r, "Show Asteriod Cone") {
// 			_showDebugAngle = !_showDebugAngle
// 		}

// 		// 	r: rl.Rectangle = {10, cast(f32)screenHeight - 100, 180, 80}
// 		// 	_showAsteroidCount = cast(bool)rl.GuiToggle(r, "Show Asteriod Count", &_showAsteroidCount)

// 		// 	r.x += 180 + 10
// 		// 	_showDebugAngle = cast(bool)rl.GuiToggle(r, "Show Asteriod Cone", &_showDebugAngle)
// 		// r: rl.Rectangle = {10, cast(f32)screenHeight - 60, 40, 40}
// 		// _showAsteroidCount = rl.GuiCheckBox(r, "Show Asteriod Count", &_showAsteroidCount)

// 		// r.y -= 30
// 		// _showDebugAngle = rl.GuiCheckBox(r, "Show Asteriod Cone", &_showDebugAngle)
//     }
// }