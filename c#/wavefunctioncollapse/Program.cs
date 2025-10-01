using Raylib_cs;
using static Raylib_cs.Raylib;
namespace wavefunctioncollapse;

class Program
{
    public static void Main()
    {
        const int screenWidth = 400;
        const int screenHeight = 400;
        const int DIM = 40;
        Util util = new Util();

        InitWindow(screenWidth, screenHeight, "wave function collapse");
        SetTargetFPS(170);

        Image city = LoadImage("images/city.png");

        List<Tile> tiles = util.extractTiles(city);

        // game loop
        while (!WindowShouldClose())
        {
            BeginDrawing();
            ClearBackground(Color.Black);
            
            // util.renderImage(tiles.ElementAt(3).img, 0, 0, 20);
            int w = screenWidth / DIM;
            int x = 0;
            int y = 0;

            for (int i = 0; i < DIM; i++)
            {
                util.renderImage(tiles.ElementAt(i).img, x, y, w);
                x += 3 * w;
                if (x > screenWidth)
                {
                    x = 0;
                    y += 3 * w;
                }
            }

            util.renderImage(city, 0, 200, w);

            EndDrawing();
        }

        CloseWindow();
    }

   
}

