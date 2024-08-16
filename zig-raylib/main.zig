const rl = @import("raylib");

pub fn main() anyerror!void {
    const screenWidth  = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "example");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
            defer rl.endDrawing();

        rl.clearBackground(rl.RAYWHITE);

        rl.drawText("ello", rl.BLACK);
    }
}
