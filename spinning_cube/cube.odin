package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

A, B, C: f64
calculateX :: proc(i: int, j: int, k: int) -> f64 {
	res: f64 =
		cast(f64)j * math.sin_f64(A) * math.sin_f64(B) * math.cos_f64(C) -
		cast(f64)k * math.cos_f64(A) * math.sin_f64(B) * math.cos_f64(C) +
		cast(f64)j * math.cos_f64(A) * math.sin_f64(C) +
		cast(f64)k * math.sin_f64(A) * math.sin_f64(C) +
		cast(f64)i * math.cos_f64(B) * math.cos_f64(C)
	return res
}

calculateY :: proc(i: int, j: int, k: int) -> f64 {
	res: f64 =
		cast(f64)j * math.cos_f64(A) * math.cos_f64(C) -
		cast(f64)k * math.sin_f64(A) * math.cos_f64(C) +
		cast(f64)j * math.sin_f64(A) * math.sin_f64(B) * math.sin_f64(C) +
		cast(f64)k * math.cos_f64(A) * math.sin_f64(B) * math.sin_f64(C) +
		cast(f64)i * math.cos_f64(B) * math.sin_f64(C)
	return res
}

calculateZ :: proc(i: int, j: int, k: int) -> f64 {
	res: f64 =
		cast(f64)k * math.cos_f64(A) * math.cos_f64(B) -
		cast(f64)j * math.sin_f64(A) * math.cos_f64(B) +
		cast(f64)i * math.sin_f64(B)
	return res
}
main :: proc() {

}
