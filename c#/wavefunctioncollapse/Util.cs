using System.ComponentModel;
using Raylib_cs;
using static Raylib_cs.Raylib;

namespace wavefunctioncollapse;

public class Util
{
    public void renderImage(Image img, int x, int y, int w)
    {
        for (int i = 0; i < img.Width; i++)
        {
            for (int j = 0; j < img.Height; j++)
            {
                DrawRectangle(x + i*w, y + j*w, w, w, GetImageColor(img, i, j));
            }
        }
    }

    public List<Tile> extractTiles(Image img) 
    {
        Image tileImage;
        List<Tile> tiles = new List<Tile>();

        for (int i = 0; i < img.Width; i++)
        {
            for (int j = 0; j < img.Height; j++)
            {
                tileImage = ImageFromImage(img, new Rectangle(i, j, 3, 3));
                // tileImage = getColors(img);
                // tileImage = copyTile(img, i, j , 3, 3, dest);
                tiles.Add(new Tile(tileImage));
            }
        }

        return tiles;
    }

    public void copyTile(Image source, int sx, int sy, int w, Image dest)
    {
        Color[] sourcePixels = getColors(source);
        Color[] destPixels = getColors(dest);
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < w; j++)
            {
                int index = (sx + i) * (sy + j) * w * 4;
                Color r = sourcePixels[index];
            }
        }
    }

    public Color[] getColors(Image img)
    {
        Color[] colors = new Color[img.Width * img.Height];
        for (int i = 0; i < img.Width; i++)
        {
            for (int j = 0; j < img.Height; j++)
            {
                colors[i * img.Width + j] = GetImageColor(img, i, j);
            }
        }
        return colors;
    }
}