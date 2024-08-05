package testing

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
     rl.InitWindow(800, 450, "testing")

     for (!rl.WindowShouldClose()) {
         rl.BeginDrawing()
         rl.ClearBackground(rl.RAYWHITE)
         rl.EndDrawing()
     }

     rl.CloseWindow()
}
