using System;
using Raylib;
using static Raylib_cs.Raylib;

namespace Examples.Core;

static class Program
{
    public static void Main()
    {
        InitWindow(400, 400, "no pyshics lib");
        App app = new App();
        SetTargetFPS(30);
        while (!WindowShouldClose())
        {
            BeginDrawing();
            app.draw();
            EndDrawing();
        }
        CloseWindow();
    }
}
