package main

import "core:fmt"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

WINDOW_WIDTH  :: 900
WINDOW_HEIGHT :: 600

Button :: struct {
    rect: rl.Rectangle,
    label: string,
}

draw_button :: proc(b: Button) -> bool {
    mouse := rl.GetMousePosition()
    hover := rl.CheckCollisionPointRec(mouse, b.rect)
    clicked := hover && rl.IsMouseButtonPressed(.LEFT)

    color := rl.LIGHTGRAY
    if hover {
        color = rl.GRAY
    }

    rl.DrawRectangleRec(b.rect, color)

    txt := strings.clone_to_cstring(b.label)
    defer delete(txt)

    rl.DrawText(txt, i32(b.rect.x)+10, i32(b.rect.y)+15, 20, rl.BLACK)

    return clicked
}

main :: proc() {
    rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Odin Audio Player")
    defer rl.CloseWindow()

    rl.InitAudioDevice()
    defer rl.CloseAudioDevice()

    rl.SetTargetFPS(60)

    // 🎵 Load playlist
    files, err := os.read_dir(context.allocator, "audio")
    if err != nil {
        return
    }

    audio_files: []string
    for f in files {
        if f.type == os.File_Type_File {
            append(&audio_files, f.name)
        }
    }

    if len(audio_files) == 0 {
        fmt.println("No audio files found")
        return
    }

    current: int = 0

    load_music :: proc(index: int) -> rl.Music {
        path := strings.concatenate([]string{"audio/", audio_files[index]}, context.allocator)
        defer delete(path)

        c_path := strings.clone_to_cstring(path)
        defer delete(c_path)

        music := rl.LoadMusicStream(c_path)
        rl.PlayMusicStream(music)
        return music
    }

    music := load_music(current)
    defer rl.UnloadMusicStream(music)

    paused := false

    // 🔘 Buttons
    prev_btn := Button{ rl.Rectangle{50, 500, 100, 40}, "PREV" }
    play_btn := Button{ rl.Rectangle{200, 500, 100, 40}, "PLAY" }
    next_btn := Button{ rl.Rectangle{350, 500, 100, 40}, "NEXT" }

    for !rl.WindowShouldClose() {

        rl.UpdateMusicStream(music)

        // 🔘 Buttons logic
        if draw_button(prev_btn) {
            rl.StopMusicStream(music)
            rl.UnloadMusicStream(music)

            current = (current - 1 + len(audio_files)) % len(audio_files)
            music = load_music(current)
            paused = false
        }

        if draw_button(play_btn) {
            paused = !paused
            if paused {
                rl.PauseMusicStream(music)
            } else {
                rl.ResumeMusicStream(music)
            }
        }

        if draw_button(next_btn) {
            rl.StopMusicStream(music)
            rl.UnloadMusicStream(music)

            current = (current + 1) % len(audio_files)
            music = load_music(current)
            paused = false
        }

        // 🎨 DRAW
        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)

        // 🎵 Current track
        track := audio_files[current]
        c_track := strings.clone_to_cstring(track)
        defer delete(c_track)

        rl.DrawText(c_track, 50, 50, 30, rl.BLACK)

        // 📋 Playlist
        for i in 0..<len(audio_files) {
            y := 120 + i * 25

            color := rl.DARKGRAY
            if i == current {
                color = rl.RED
            }

            txt := strings.clone_to_cstring(audio_files[i])
            defer delete(txt)

            rl.DrawText(txt, 50, i32(y), 20, color)
        }

        rl.EndDrawing()
    }
}
