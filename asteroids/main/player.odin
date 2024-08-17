package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

Player :: struct {
    position:   rl.Vector2,
    velocity:   rl.Vector2,
    rotation:   int,
}

PlayerUpdate :: proc(player: ^Player) {
    xIn: int = cast(int)rl.IsKeyDown(rl.KeyboardKey.RIGHT) - cast(int)rl.IsKeyDown(rl.KeyboardKey.LEFT)
    player.rotation += (xIn * PLAYER_ROT_SPEED * cast(int)rl.GetFrameTime())
}

PlayerDraw :: proc(player: Player) {
    rl.DrawPoly(player.position, 3, 64, cast(f32)player.rotation, rl.WHITE)
}