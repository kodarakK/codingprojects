package main

import "core:fmt"
import "core:math/rand"
import "core:math"
import rl "vendor:raylib"

Player :: struct {
    position:   rl.Vector2,
    velocity:   rl.Vector2,
    rotation:   f32,
}

PlayerUpdate :: proc(player: ^Player) {
    yIn: int = cast(int)rl.IsKeyDown(rl.KeyboardKey.UP) - cast(int)rl.IsKeyDown(rl.KeyboardKey.DOWN)
    frametime: f32 = rl.GetFrameTime()
    xIn: int = cast(int)rl.IsKeyDown(rl.KeyboardKey.RIGHT) - cast(int)rl.IsKeyDown(rl.KeyboardKey.LEFT)
    player.rotation -= (cast(f32)xIn * PLAYER_ROT_SPEED * rl.GetFrameTime())

    mag: f32 = rl.Vector2Length(player.velocity)

    magSqr: f32 = rl.Vector2LengthSqr(player.velocity)
    if yIn > 0 {
        facingDirection: rl.Vector2 = rl.Vector2Rotate({0, 1}, player.rotation * rl.DEG2RAD)
        player.velocity = player.velocity + facingDirection * PLAYER_ACCELERATION * frametime
        mag: f32 = rl.Vector2Length(player.velocity)

        if mag > PLAYER_SPEED {
            player.velocity = player.velocity * (PLAYER_SPEED/mag)
        }
    }
    else {

        if mag > 0 {
            xSign: f32 = (player.velocity.x < 0) ? -1.0: 1.0
            ySign: f32 = (player.velocity.y < 0) ? -1.0: 1.0

            xAbs: f32 = player.velocity.x * xSign
            yAbs: f32 = player.velocity.y * ySign

            xWeight: f32 = xAbs * xAbs / magSqr
            yWeight: f32 = yAbs * yAbs / magSqr

            xDecel: f32 = xWeight * PLAYER_DEACCELERATION * xSign
            yDecel: f32 = yWeight * PLAYER_DEACCELERATION * ySign

            player.velocity.x = (xAbs >  xDecel) ? player.velocity.x - xDecel : 0
            player.velocity.y = (yAbs >  yDecel) ? player.velocity.y - yDecel : 0
        }
    }


    player.position = player.position + (player.velocity * frametime)




    SetPlayerInfo(player.position, player.velocity, player.rotation)
}

PlayerDraw :: proc(player: Player) {
    rl.DrawPoly(player.position, 3, 32, player.rotation, rl.RAYWHITE)
}