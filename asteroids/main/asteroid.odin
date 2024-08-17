package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

// Asteroid stuff
ASTEROID_SPEED_MIN :: 100
ASTEROID_SPEED_MAX :: 225
MAX_ASTEROIDS :: 64
ASTEROID_ROT_SPEED_MIN: i32 : 5
ASTEROID_ROT_SPEED_MAX: i32 : 240
ASTERIOD_LIFE: f32 : 10.0
ASTERIOD_DELAY: f32 : 0.75
ASTEROID_RANDOM_ANGLE: f32 : 20 * rl.DEG2RAD
NEARBLACK: rl.Color : {15, 15, 15, 255}
_asteroids: [MAX_ASTEROIDS]Asteroid
_lastAsteriodCreationTime: f32 = -1.0
_sizes := [3]AsteroidSize {
	AsteroidSize.ASTEROID_SMALL,
	AsteroidSize.ASTEROID_MEDIUM,
	AsteroidSize.ASTEROID_LARGE,
}

screenWidth: i32 : 600
screenHeight: i32 : 600
screenCenter :: rl.Vector2{cast(f32)screenWidth / 2, cast(f32)screenHeight / 2}

// DEBUG
_showDebugMenu: bool = false
_showDebugAngle: bool = false
_showAsteroidCount: bool = false

line0: [2]rl.Vector2
line1: [2]rl.Vector2

//


AsteroidSize :: enum {
	ASTEROID_SMALL  = 1,
	ASTEROID_MEDIUM = 2,
	ASTEROID_LARGE  = 4,
}

Asteroid :: struct {
	active:        bool,
	size:          AsteroidSize,
	position:      rl.Vector2,
	rotation:      f32,
	rotationSpeed: f32,
	velocity:      rl.Vector2,
	creationTime:  f32,
}

CreateAsteroid :: proc(
	position: rl.Vector2,
	velocity: rl.Vector2,
	size: AsteroidSize,
) -> Asteroid {

	asteroid := Asteroid {
		active        = true,
		size          = size,
		position      = position,
		velocity      = velocity,
		rotation      = cast(f32)rl.GetRandomValue(0, 360),
		rotationSpeed = cast(f32)rl.GetRandomValue(ASTEROID_ROT_SPEED_MIN, ASTEROID_ROT_SPEED_MAX),
		creationTime  = cast(f32)rl.GetTime(),
	}
	return asteroid
}

AsteroidUpdate :: proc(asteroid: ^Asteroid, frametime: f32, time: f32) {
	if !asteroid.active {
		return
	}

	if time > asteroid.creationTime + ASTERIOD_LIFE {
		asteroid.active = false
		return
	}


	asteroid.position = asteroid.position + (asteroid.velocity * frametime)
	asteroid.rotation += asteroid.rotationSpeed * frametime
}

AsteroidDraw :: proc(asteroid: Asteroid) {
	if !asteroid.active {
		return
	}

	rl.DrawPolyLines(
		asteroid.position,
		3,
		cast(f32)(16 * cast(int)asteroid.size),
		asteroid.rotation,
		rl.WHITE,
	)
}

AddAsteroid :: proc(position: rl.Vector2, velocity: rl.Vector2, size: AsteroidSize) {

	created: bool = false
	velocity: rl.Vector2 = screenCenter - position
	velocity =
		rl.Vector2Normalize(velocity) *
		cast(f32)rl.GetRandomValue(ASTEROID_SPEED_MIN, ASTEROID_SPEED_MAX)

	if _showDebugAngle {
		line0[0] = position
		line1[0] = position

		line0[1] = position + rl.Vector2Rotate(velocity * 10, -ASTEROID_RANDOM_ANGLE)
		line1[1] = position + rl.Vector2Rotate(velocity * 10, ASTEROID_RANDOM_ANGLE)
	}
	velocity = rl.Vector2Rotate(
		velocity,
		cast(f32)rand.float32_range(-ASTEROID_RANDOM_ANGLE, ASTEROID_RANDOM_ANGLE),
	)

	for i in 0 ..< MAX_ASTEROIDS {
		if _asteroids[i].active {
			continue
		}

		_asteroids[i] = CreateAsteroid(position, velocity, size)
		created = true
		break
	}

	if !created {
		fmt.println(
			"Failed to create an asteroid because there was no inactive spots in the array!",
		)
	}
}

GetNextAsteroidPosition :: proc() -> rl.Vector2 {
	padding: f32 = 128
	result: rl.Vector2 = {-padding, -padding}
	switch rl.GetRandomValue(0, 1) {
	case 1:
		switch rl.GetRandomValue(0, 1) {
		case 1:
			result.y = cast(f32)screenHeight + padding
		case 0:
		}
		result.x = cast(f32)rl.GetRandomValue(-cast(i32)padding, screenWidth + cast(i32)padding)
	case 0:
		switch rl.GetRandomValue(0, 1) {
		case 1:
			result.x = cast(f32)screenWidth + padding
		case 0:
		}
		result.y = cast(f32)rl.GetRandomValue(-cast(i32)padding, screenHeight + cast(i32)padding)
	}

	return result
}

