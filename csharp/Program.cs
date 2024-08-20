// See https://aka.ms/new-console-template for more information
using Raylib_cs;

static class Program 
{
    public static void Main() 
    {
        Raylib.InitWindow(600, 450, "cshapr");

        Segment s = new Segment(0, 0);

        while (!Raylib.WindowShouldClose())
        {
            Raylib.BeginDrawing();

            Raylib.EndDrawing();
        }

        Raylib.CloseWindow();
    }
}
