package audio_player

import "core:fmt"
import "core:log"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

WINDOW_HEIGHT :: 600;
WINDOW_WIDTH  :: 800;

Button :: struct {
    rect: rl.Rectangle,
    label: string,
}

draw_button :: proc(b: Button) -> bool {
    mouse := rl.GetMousePosition()

    hover := rl.CheckCollisionPointRec(mouse, b.rect)
    clicked := hover && rl.IsMouseButtonPressed(rl.MouseButton.LEFT)

    color := rl.LIGHTGRAY
    if hover {
        color = rl.GRAY
    }

    rl.DrawRectangleRec(b.rect, color)

    text := strings.clone_to_cstring(b.label)
    defer delete(text)

    rl.DrawText(
        text,
        i32(b.rect.x) + 10,
        i32(b.rect.y) + 15,
        20,
        rl.BLACK,
    )

    return clicked
}

main :: proc() {
    logger := log.create_console_logger();
    context.logger = logger;
    rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "audio player");
    defer rl.CloseWindow();

    rl.InitAudioDevice();
    defer rl.CloseAudioDevice();

    music: rl.Music;
    defer rl.UnloadMusicStream(music);

    rl.SetTargetFPS(60);

    rl.PlayMusicStream(music);

    pause: bool = true;

    dir := "audio";

    files, err := os.read_directory_by_path(dir, 0, context.allocator);

    audio_files: [dynamic]string;
    for file in files {
        if os.is_file(file.fullpath) {
            append(&audio_files, file.name);
        }
    }

    selected_audio_file: int = 0;

    music = rl.LoadMusicStream(strings.clone_to_cstring(audio_files[selected_audio_file]));

    for (!rl.WindowShouldClose()) {
        // update

        /* update music buffer with new stream data */
        rl.UpdateMusicStream(music);

        /* setup input controls */
        if (rl.IsKeyPressed(.P)) {
            pause = !pause;
            if (pause) {
                rl.PauseMusicStream(music);
                log.info("pauseer de music");
            }
            else {
                rl.ResumeMusicStream(music);
                log.info("start de music");
            } 
        }

        /* music selection */
        if (rl.IsKeyPressed(.DOWN)) {
            selected_audio_file = (selected_audio_file + 1) % len(audio_files);
        }
        
        if (rl.IsKeyPressed(.UP)) {
            selected_audio_file = (selected_audio_file - 1) % len(audio_files);
        }

        if (rl.IsKeyPressed(.ENTER)) {
            rl.StopMusicStream(music);
            rl.UnloadMusicStream(music);
            pause = false;

            path := strings.concatenate([]string{"audio/", audio_files[selected_audio_file]});
            music = rl.LoadMusicStream(strings.clone_to_cstring(path));
            rl.PlayMusicStream(music);
        }
        

        // draw
        {
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);
            
            title_text: cstring = "PRESS P TO PAUSE AND START";
            rl.DrawText(title_text, (WINDOW_WIDTH - rl.MeasureText(title_text, 20))/2, WINDOW_HEIGHT/2 + 150, 20, rl.LIGHTGRAY);
            text: cstring = pause ? "START" : "PAUSE";
            rl.DrawText(text, (WINDOW_WIDTH - rl.MeasureText(text, 20))/2, WINDOW_HEIGHT/2, 20, rl.DARKGRAY);

            /* audio selector */
            for i in 0..<len(audio_files) {
                y := 100 + i * 30;

                color := rl.BLACK;

                if i == selected_audio_file {
                    color = rl.RED;
                }

                rl.DrawText(strings.clone_to_cstring(audio_files[i]), 100, i32(y), 20, color);
            }
        }
    }
    
}
