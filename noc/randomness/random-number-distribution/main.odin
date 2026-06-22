package rnd;

import rl "vendor:raylib";
import random "core:math/rand";
import time "core:time";

width :: 1280;
height :: 720;

main :: proc() {
	rl.InitWindow(width, height, "Random number Distribution");

	total :: 20;
	randomCounts: [total]int;
	for !rl.WindowShouldClose() {
		index := random.int_range(0, total);
		if !(randomCounts[index] == height) {
			randomCounts[index] += 1;
		}
		time.sleep(1 * time.Millisecond);
		w := width / len(randomCounts);
		rl.BeginDrawing();
		rl.ClearBackground({160, 200, 255, 255});
		for x in 0..<len(randomCounts) {
			rl.DrawRectangle((i32)(x * w), (i32)(height - randomCounts[x]), (i32)(w - 1), (i32)(randomCounts[x]), rl.GRAY);
		}
		rl.EndDrawing();
	}
	rl.CloseWindow();
}
