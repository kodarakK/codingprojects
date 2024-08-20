using Raylib;
using Raylib_cs;
using System.Numerics;
using System;
using static Raylib_cs.Raylib;

namespace Examples.Core;

static class Program
{
    public static void Main()
    {
        InitWindow(1000, 1000, "Dragon Curve");

        List<Segment> segments = new List<Segment>();
        Vector2 b = new Vector2(500, 100);
        Vector2 a = new Vector2(500, 110);

        segments.Add(new Segment(a, b));

        Vector2 endPoint = segments[segments.Count() - 1].getB();

        while (!WindowShouldClose())
        {

            if (IsMouseButtonPressed(MouseButton.Left))
            {
                List<Segment> newSegments = new List<Segment>();
                foreach (Segment s in segments)
                {
                    newSegments.Add(s.rotate(endPoint));
                }

                endPoint = newSegments[0].getA();

                segments.AddRange(newSegments);
            }

            BeginDrawing();
            ClearBackground(Color.RayWhite);

            foreach (Segment s in segments)
            {
                s.show();
            }

            EndDrawing();
        }

        CloseWindow();
    }
}