using static Raylib_cs.Raylib;
using static Raylib.Color;

namespace Raylib;

static class Program
{
    public static void Main() 
    {
        InitWindow(600, 600, "test");

        while (!WindowShouldClose())
        {
            BeginDrawing();
            ClearBackground(Color.Raywhite);
            EndDrawing();
        }

        CloseWindow();
    }
}